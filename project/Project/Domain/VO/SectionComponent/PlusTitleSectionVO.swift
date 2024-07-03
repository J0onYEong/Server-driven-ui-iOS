//
//  PlusTitleSectionVO.swift
//  App
//
//  Created by choijunios on 7/1/24.
//

import Foundation

public struct PlusTitleSectionVO {
    
    public let firstRowImageUrl: RowImage
    public let titleText: TitleText
    public let badges: [Badge]
    public let description: String
    
    public init(firstRowImageUrl: RowImage, titleText: TitleText, badges: [Badge], description: String) {
        self.firstRowImageUrl = firstRowImageUrl
        self.titleText = titleText
        self.badges = badges
        self.description = description
    }
    
    public struct RowImage {
        
        public let imageUrl: URL
        public let width: CGFloat
        public let height: CGFloat
        
        public init(imageUrl: URL, width: CGFloat, height: CGFloat) {
            self.imageUrl = imageUrl
            self.width = width
            self.height = height
        }
    }

    public struct TitleText {
        
        public let text: String
        public let textSize: CGFloat
        public let textColor: String
        public let textStyle: TextStyle
        
        public init(text: String, textSize: CGFloat, textColor: String, textStyle: TextStyle) {
            self.text = text
            self.textSize = textSize
            self.textColor = textColor
            self.textStyle = textStyle
        }
    }

    public enum TextStyle: String {
        case bold="bold"
        case italic="italic"
        case strike="strike"
    }

    public struct Badge {
        
        public let badgeImageUrl: URL
        public let text: String
        
        public init(badgeImageUrl: URL, text: String) {
            self.badgeImageUrl = badgeImageUrl
            self.text = text
        }
    }
}

extension PlusTitleSectionVO: SectionComponentVO {
    
    public var type: SectionComponent { .title_plus }
}
