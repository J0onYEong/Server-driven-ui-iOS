## Server-driven-ui-iOS

- 모듈 의존방향 그래프

    ![Module dependency graph](graph.png)


### 디코딩 과정

홈화면을 구성하는 컴포넌트는 서버에서 어떤 타입을 내려주느냐따라서 달라질 수 있습니다.
따라서 추상화가 필요하였고  ContentDTO라는 enum타입으로 우선 디코딩이 진행됩니다.
```swift
init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: DecodingKeys.self)
    
    self.screenName = try container.decode(String.self, forKey: .screenName)
    
    switch self.screenName {
    case "Home":
        self.contents = try container.decode([ContentDTO].self, forKey: .contents)
    default:
        throw DecodingError.unknownScreenType
    }
}
```

ContentDTO를 enum으로 정의한 이유는 서버에의해 등장할 수 있는 컴포넌트를 제한하여 디코딩을 용이하게 하기 위해서 입니다.
물론 문자열을 사용하여 처리할 수 있지만 자유도를 너무 높이는 것은 가독성을 떨어트릴 수 있다고 생각했습니다.

ContentDTO는 디코딩시 contentType필드 값에 따라 특정 항목으로 분류되게 됩니다. 
분류된 항목에 따라 enum에 연관값을 저장하였습니다.
```swift
enum ContentDTO: Decodable {
    
    case title_section(dto: any EntityRepresentable)
    case plus_title_section(dto: any EntityRepresentable)
    
    private enum DecodingKeys: String, CodingKey {
        case contentType = "sectionComponentType"
        case section
    }
    
    init(from decoder: any Decoder) throws {
        
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        let contentType = try container.decode(String.self, forKey: .contentType)
        self = try Self.decodeComponent(type: contentType, container: container)
    }
    
    private static func decodeComponent(type: String, container: KeyedDecodingContainer<DecodingKeys>) throws -> Self {
        
        // MARK: ✅ SectionComponent가 추가되는 경우 수정해야 하는 부분입니다.
        switch type {
        case "TITLE":
            let decodedObject = try container.decode(TitleDTO.self, forKey: .section)
            return .title_section(dto: decodedObject)
            
        case "PLUS_TITLE":
            let decodedObject = try container.decode(PlusTitleDTO.self, forKey: .section)
            return .plus_title_section(dto: decodedObject)
        default:
            
            throw DecodingError.unknownSectionComponent
        }
    }
}

```

EntityRepresentable을 conform하는 TitleDTO, PlusTitleDTO는 항목의 연관값으로 저장된 후 
아래와같이 toEntity추상 매서드를 통해 정의한 방식대로 디코딩됩니다.
엔티티화 되어도 SectionComponentVO추상화 되어 있어 하나의 컬랙션에 담겨 도메인으로 이동할 수 있습니다.
```swift
func toEntity() -> ScreenVO {
    
    // MARK: ✅ Section이 추가되는 경우 수정해야 하는 부분입니다.
    let contents = contents.map {
        switch $0 {
        case .plus_title_section(let dto):
            ✋✋✋
            return dto.toEntity()
        case .title_section(dto: let dto):
            ✋✋✋
            return dto.toEntity()
        }
    }.compactMap { $0 as? SectionComponentVO }
    
    return ScreenVO(
        screenType: ScreenType(rawValue: screenName ?? "") ?? .unknown,
        contents: contents
    )
}
```

SectionComponentVO는 프로토콜 타입으로, 추상화 되어 있찌만 type프로퍼티를 통해 어떤 구체타입을 나타내는지 확인할 수 있도록 하였습니다.
```swift
public enum SectionComponent {
    
    case title
    case title_plus
}

public protocol SectionComponentVO {
    
    var type: SectionComponent { get }
}
```

해당 타입은 최종적으로 위 프로퍼티를 기준으로 Presentation 영역에서 생성할 UI를 결정하게 됩니다.

```swift
public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let component = contents[indexPath.row]
    switch component.type {
    ✋✋✋
    case .title :
        if let tileComponent = component as? TitleSectionVO {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewTitleCell.cellID, for :
indexPath) as! TableViewTitleCell
            cell.bind(titleSectionVO: tileComponent)
            return cell
        }
    ✋✋✋
    case .title_plus :
        if let tilePlusComponent = component as? PlusTitleSectionVO {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewPlusTitleCell.cellID, for :
indexPath) as! TableViewPlusTitleCell
            cell.bind(plusTitleSectionVO : tilePlusComponent)
            return cell
        }
    }
    
    return UITableViewCell()
}
```

## 회고

- JSON필드가 가진 값이 Swift의 타입으로 변환되는 과정에 깊게 관여하는 경험이 되었습니다.
- 추상화된 객체를 구체화하고 최종적으로 UI로 시각함으로써 객체의 다형성을 구현하였습니다. 이를 통해서 서버로부터온 UI정보에 대응할 수 있는 시스템을 구축하였습니다. 후에 개발중인 프로덕트에 해당 기능을 도입하여 A/B 테스트와 같은 실험을 해보고 싶습니다.
