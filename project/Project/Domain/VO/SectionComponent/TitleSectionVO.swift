//
//  TitleSectionVO.swift
//  App
//
//  Created by choijunios on 7/1/24.
//

import Foundation

public struct TitleSectionVO {
    
    public let titleText: String
    public let badges: [Badge]
    public let description: String
    
    public init(titleText: String, badges: [Badge], description: String) {
        self.titleText = titleText
        self.badges = badges
        self.description = description
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

extension TitleSectionVO: SectionComponentVO {
    
    public var type: SectionComponent { .title }
}
