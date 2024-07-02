//
//  ScreenDTO.swift
//  Data
//
//  Created by choijunios on 7/2/24.
//

import Foundation

struct ScreenDTO: Decodable {
    
    var screenName: String
    var contents: [ContentDTO]
    
    enum DecodingKeys: String, CodingKey {
        case screenName
        case contents
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        self.screenName = try container.decode(String.self, forKey: .screenName)
        
        switch self.screenName {
        case "Home":
            self.contents = try container.decode([HomeContentDTO].self, forKey: .contents)
        default:
            throw DecodingError.unknownScreenType
        }
    }
}

protocol ContentDTO: Decodable { }

protocol SectionComponentDTO: Decodable & EntitiyRepresentable {
    
    var type: String? { get }
}
