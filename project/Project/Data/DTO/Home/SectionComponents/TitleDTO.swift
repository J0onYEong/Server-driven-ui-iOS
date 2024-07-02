//
//  TitleDTO.swift
//  Data
//
//  Created by choijunios on 7/2/24.
//

import Foundation
import Domain

// MARK: Title
struct TitleDTO: Decodable {
    
    typealias RawValue = Self
    
    let type: String?
    let title: String?
    var badges: [BadgeDTO] = []
    let description: String?
    
    public struct BadgeDTO: Decodable {
        
        let badgeImage: String?
        let text: String?
    }
}

extension TitleDTO: EntityRepresentable {
    
    func toEntity() -> SectionComponentVO {
        
        let defaultImagePath = "defaultImage"
        
        let badges = badges.map({ dto in
            
            return TitleSectionVO.Badge(
                badgeImageUrl: URL(string: dto.badgeImage ?? defaultImagePath)!,
                text: dto.text ?? ""
            )
        })
        
        return TitleSectionVO(
            titleText: title ?? "unknown",
            badges: badges,
            description: description ?? ""
        )
    }
}
