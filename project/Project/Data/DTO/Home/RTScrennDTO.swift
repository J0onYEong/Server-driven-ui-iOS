//
//  RTScrennDTO.swift
//  Data
//
//  Created by 최재혁 on 7/11/24.
//

import Foundation
import Domain

struct RTResponseData : Decodable {
    let responseData : RTScrennDTO
    
    enum DecodingKeys: String, CodingKey {
        case responseData
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        self.responseData = try container.decode(RTScrennDTO.self, forKey: .responseData)
    }
}

struct RTScrennDTO : Decodable {
    
    let screenName : String?
    var contents : [RTContentDTO] = []
    
    enum DecodingKeys: String, CodingKey {
        case screenName
        case contents
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        self.screenName = try container.decode(String.self, forKey: .screenName)
        switch self.screenName {
        case "Home":
            self.contents = try container.decode([RTContentDTO].self, forKey: .contents)
        default:
            throw DecodingError.unknownScreenType
        }
    }
}

extension RTScrennDTO : EntityRepresentable {
    func toEntity() -> RTScreenVO {
        let contents = contents.map {
            switch $0 {
            case .AViewType(let dto) :
                return dto.toEntity()
            case .BViewType(let dto) :
                return dto.toEntity()
            case .RichViewType(let dto) :
                return dto.toEntity
            }
        }.compactMap { $0 as? ViewContentVO }
        
        return RTScreenVO(
            screenName: screenName ?? "",
            contents: contents
        )
    }
}
