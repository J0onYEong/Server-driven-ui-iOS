//
//  PlusTitleDTO.swift
//  Data
//
//  Created by choijunios on 7/2/24.
//

import Foundation
import Domain

// MARK: Plus title
struct PlusTitleDTO: Decodable {
    
    let type: String?
    let firstRowImage: RowImage?
    let titleText: TitleText?
    var badges: [BadgeDTO] = []
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
}

extension PlusTitleDTO: EntitiyRepresentable {
    
    func toEntity() -> SectionComponentVO {
        
        let defaultImagePath = "defaultImage"
        
        let defaultImageWidth = 0.0
        let defaultImageHeight = 0.0
        
        let defaultTextSize = 17.0
        
        let badges = badges.map({ dto in
            
            return PlusTitleSectionVO.Badge(
                badgeImageUrl: URL(string: dto.badgeImage ?? defaultImagePath)!,
                text: dto.text ?? ""
            )
        })
        
        let firstRowImage = PlusTitleSectionVO.RowImage(
            imageUrl: URL(string: firstRowImage?.imageUrl ?? defaultImagePath)!,
            width: CGFloat(Double(firstRowImage?.width ?? "") ?? defaultImageWidth),
            height: CGFloat(Double(firstRowImage?.height ?? "") ?? defaultImageHeight)
        )
        
        let titleText = PlusTitleSectionVO.TitleText(
            text: titleText?.text ?? "",
            textSize: CGFloat(Double(titleText?.textSize ?? "") ?? defaultTextSize),
            textColor: titleText?.textColor ?? "",
            textStyle: PlusTitleSectionVO.TextStyle(rawValue: titleText?.textStyle ?? "") ?? .bold
        )
        
        return PlusTitleSectionVO(
            firstRowImageUrl: firstRowImage,
            titleText: titleText,
            badges: badges,
            description: description ?? ""
        )
    }
}
