//
//  RTScreenVO.swift
//  Domain
//
//  Created by choijunios on 7/9/24.
//

import Foundation

public struct RTScreenVO {
    
    public let screenName: String
    public let contents: [ViewContentVO]
    
    public init(screenName: String, contents: [ViewContentVO]) {
        self.screenName = screenName
        self.contents = contents
    }
}
