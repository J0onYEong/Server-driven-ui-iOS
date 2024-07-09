//
//  ViewTypeContentable.swift
//  Domain
//
//  Created by choijunios on 7/9/24.
//

import Foundation

public enum ViewTypeContentType {
    case title
    case icon
    case richText
}

public protocol ViewTypeContentable {
    
    var type: ViewTypeContentType { get }
}
