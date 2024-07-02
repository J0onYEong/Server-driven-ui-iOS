//
//  EntitiyRepresentable.swift
//  App
//
//  Created by choijunios on 7/2/24.
//

import Foundation

protocol EntitiyRepresentable {
    associatedtype EntityType
    func toEntity() -> EntityType
}
