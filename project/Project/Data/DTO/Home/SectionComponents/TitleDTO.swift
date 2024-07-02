//
//  TitleDTO.swift
//  Data
//
//  Created by choijunios on 7/2/24.
//

import Foundation
import Domain

extension HomeContentDTO {
    
    // MARK: Title
    struct TitleDTO: SectionComponentDTO {
        
        typealias RawValue = Self
        
        let type: String?
        let title: String?
        let badges: [BadgeDTO]?
        let description: String?
        
        public struct BadgeDTO: Decodable {
            
            let badgeImage: String?
            let text: String?
        }
        
        typealias EntityType = String
        func toEntity() -> EntityType {
            
            return ""
        }
    }
}
