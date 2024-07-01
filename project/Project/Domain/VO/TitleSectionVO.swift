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
    
    public struct Badge {
        
        public let badgeImageUrl: URL
        public let text: String
    }
}
