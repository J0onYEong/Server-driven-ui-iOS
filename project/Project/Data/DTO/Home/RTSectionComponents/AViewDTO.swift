//
//  AViewDTO.swift
//  Data
//
//  Created by 최재혁 on 7/11/24.
//

import Foundation
import Domain

struct AViewDTO : Decodable {
    let title : String?
    let iconUrl : String?
}

extension AViewDTO : EntityRepresentable {
    func toEntity() -> ViewTypeContentable {
        let imageUrl = URL(string: iconUrl ?? "")!
        return IconContentVO(imageUrl: imageUrl)
    }
}
