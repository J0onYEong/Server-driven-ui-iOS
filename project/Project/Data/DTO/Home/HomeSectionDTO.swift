//
//  HomeSectionDTO.swift
//  Data
//
//  Created by choijunios on 7/2/24.
//

import Foundation

enum HomeContentDTO: ContentDTO {
    
    case title_section(dto: any SectionComponentDTO)
    case plus_title_section(dto: any SectionComponentDTO)
    
    private enum DecodingKeys: CodingKey {
        case sectionComponentType
        case section
    }
    
    init(from decoder: any Decoder) throws {
        
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        let componentTypeStr = try container.decode(String.self, forKey: .sectionComponentType)
        self = try Self.decodeComponent(type: componentTypeStr, container: container)
    }
    
    private static func decodeComponent(type: String, container: KeyedDecodingContainer<DecodingKeys>) throws -> Self {
        
        // MARK: ✅ Section이 추가되는 경우 수정해야 하는 부분입니다.
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

