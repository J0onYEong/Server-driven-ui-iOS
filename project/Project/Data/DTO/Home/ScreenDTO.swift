//
//  ScreenDTO.swift
//  Data
//
//  Created by choijunios on 7/2/24.
//

import Foundation
import Domain

struct ScreenDTO: Decodable {
    
    let screenName: String?
    var contents: [ContentDTO] = []
    
    enum DecodingKeys: String, CodingKey {
        case screenName
        case contents
    }
    
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
}

extension ScreenDTO: EntitiyRepresentable {
    
    func toEntity() -> ScreenVO {
        
        // MARK: ✅ Section이 추가되는 경우 수정해야 하는 부분입니다.
        let contents = contents.map {
            switch $0 {
            case .plus_title_section(let dto):
                return dto.toEntity()
            case .title_section(dto: let dto):
                return dto.toEntity()
            }
        }.compactMap { $0 as? SectionComponentVO }
        
        return ScreenVO(
            screenType: ScreenType(rawValue: screenName ?? "") ?? .unknown,
            contents: contents
        )
    }
}
