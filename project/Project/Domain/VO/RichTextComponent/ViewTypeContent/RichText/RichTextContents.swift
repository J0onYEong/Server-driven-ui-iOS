//
//  RichTextContents.swift
//  Domain
//
//  Created by choijunios on 7/9/24.
//

import Foundation

public extension RichTextContentVO {
    
    /// 리치테스트중 텍스트를 표현합니다.
    struct RTTextVO: RichTextable {
        public let type: RichTextType = .text
        
        public let text: String
        public let fontSize: CGFloat
        public let background: String
        public let textStyle: [String]
        
        public init(text: String, fontSize: CGFloat, background: String, textStyle: [String] = []) {
            self.text = text
            self.fontSize = fontSize
            self.background = background
            self.textStyle = textStyle
        }
    }
    
    /// 리치테스트중 이미지를 표현합니다.
    struct RTImageVO: RichTextable {
        public let type: RichTextType = .image
        
        public let url: URL
        public let width: CGFloat
        public let height: CGFloat
        
        public init(url: URL, width: CGFloat, height: CGFloat) {
            self.url = url
            self.width = width
            self.height = height
        }
    }
}
