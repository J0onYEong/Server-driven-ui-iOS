//
//  ViewContentVO.swift
//  Domain
//
//  Created by choijunios on 7/9/24.
//

import Foundation

public struct ViewContentVO {
    
    public let viewType: String
    public let content: [ViewTypeContentable]
    
    public init(viewType: String, content: [ViewTypeContentable]) {
        self.viewType = viewType
        self.content = content
    }
}
