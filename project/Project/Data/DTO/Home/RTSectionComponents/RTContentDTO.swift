//
//  ContentDTO.swift
//  Data
//
//  Created by 최재혁 on 7/11/24.
//

import Foundation

enum RTContentDTO : Decodable {
    case AViewType(dto : any EntityRepresentable)
    case BViewType(dto : any EntityRepresentable)
    case RichViewType(dto : any EntityRepresentable)
    
    private enum DecodingKeys: CodingKey {
        case viewType
        case content
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        let viewType = try container.decode(String.self, forKey: .viewType)
        self = try Self.decodeComponent(type: viewType, container: container)
    }
    
    private static func decodeComponent(type: String, container: KeyedDecodingContainer<DecodingKeys>) throws -> Self {
        switch type {
        case "AViewType":
            let decodedObject = try container.decode(AViewDTO.self, forKey: .content)
            return .AViewType(dto: decodedObject)
        case "BViewType":
            let decodedObject = try container.decode(BViewDTO.self, forKey: .content)
            return .BViewType(dto: decodedObject)
        case "RichViewType":
            let decodedObject = try container.decode(RichViewDTO.self, forKey: .content)
            return .RichViewType(dto: decodedObject)
        default:
            throw DecodingError.unknownViewType
        }
    }
}
