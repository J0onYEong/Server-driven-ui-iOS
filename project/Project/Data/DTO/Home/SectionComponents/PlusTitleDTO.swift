//
//  PlusTitleDTO.swift
//  Data
//
//  Created by choijunios on 7/2/24.
//

import Foundation

extension HomeContentDTO {
    
    // MARK: Plus title
    struct PlusTitleDTO: SectionComponentDTO {
        
        let type: String?
        let firstRowImage: RowImage?
        let titleText: TitleText?
        let badges: [BadgeDTO]?
        let description: String?
        
        public struct RowImage: Decodable {
            
            let imageUrl: String?
            let width: String?
            let height: String?
        }
        
        public struct TitleText: Decodable {
            
            let text: String?
            let textSize: String?
            let textColor: String?
            let textStyle: String?
        }
        
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
