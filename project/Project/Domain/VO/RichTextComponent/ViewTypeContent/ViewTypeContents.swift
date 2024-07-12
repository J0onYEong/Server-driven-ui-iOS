//
//  ViewTypeContents.swift
//  Domain
//
//  Created by choijunios on 7/9/24.
//

import Foundation

/// 텍스트 컨테츠 입니다. (Rich Text ❌)
public struct TitleContentVO: ViewTypeContentable {
    
    public let type: ViewTypeContentType = .title
    public let content: String
    
    public init(content: String) {
        self.content = content
    }
}

/// 아이콘 컨텐츠 입니다. (Rich Text ❌)
public struct IconContentVO: ViewTypeContentable {
    
    public let type: ViewTypeContentType = .icon
    public let imageUrl: URL
    
    public init(imageUrl: URL) {
        self.imageUrl = imageUrl
    }
}

/// 리치 텍스트드을 보유하는 타입입니다.
public struct RichTextContentVO: ViewTypeContentable {
    
    public let type: ViewTypeContentType = .richText
    public let content: [RichTextable]
    
    public init(content: [RichTextable]) {
        self.content = content
    }
}
