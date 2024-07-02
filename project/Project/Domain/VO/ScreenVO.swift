//
//  ScreenVO.swift
//  Domain
//
//  Created by choijunios on 7/2/24.
//

import Foundation

public enum ScreenType: String {
    case Home="Home"
    case unknown
}

public struct ScreenVO {
    
    public let screenType: ScreenType
    
    public let contents: [SectionComponentVO]
    
    public init(screenType: ScreenType, contents: [SectionComponentVO]) {
        self.screenType = screenType
        self.contents = contents
    }
}
