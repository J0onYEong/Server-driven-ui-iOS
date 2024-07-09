//
//  RichTextable.swift
//  Domain
//
//  Created by choijunios on 7/9/24.
//

import Foundation

public enum RichTextType {
    case text
    case image
}

public protocol RichTextable {
    var type: RichTextType { get }
}
