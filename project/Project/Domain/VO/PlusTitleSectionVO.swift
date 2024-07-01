//
//  PlusTitleSectionVO.swift
//  App
//
//  Created by choijunios on 7/1/24.
//

import Foundation

struct PlusTitleSectionVO {
    
    public let firstRowImageUrl: RowImage
    public let titleText: TitleText
    public let badges: [Badge]
    public let description: String
    
    public struct RowImage {
        
        public let imageUrl: URL
        public let width: CGFloat
        public let height: CGFloat
    }

    public struct TitleText {
        
        public let text: String
        public let textSize: CGFloat
        public let textColor: String
        public let textStyle: TextStyle
    }

    public enum TextStyle {
        case bold
        case italic
        case strike
    }

    public struct Badge {
        
        public let badgeImageUrl: URL
        public let text: String
    }
}


