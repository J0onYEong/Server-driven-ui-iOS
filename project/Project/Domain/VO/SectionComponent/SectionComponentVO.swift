//
//  HomeScreenVO.swift
//  Domain
//
//  Created by choijunios on 7/2/24.
//

import Foundation

public enum SectionComponent {
    
    case title
    case title_plus
}

public protocol SectionComponentVO {
    
    var type: SectionComponent { get }
}
