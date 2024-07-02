//
//  EntitiyRepresentable.swift
//  App
//
//  Created by choijunios on 7/2/24.
//

import Foundation

protocol EntityRepresentable {
    associatedtype EntityType
    func toEntity() -> EntityType
}
