//
//  BViewDTO.swift
//  Data
//
//  Created by 최재혁 on 7/11/24.
//

import Foundation
import Domain

struct BViewDTO : Decodable {
    let title : String?
}

extension BViewDTO : EntityRepresentable {
    func toEntity() -> ViewTypeContentable {
        return TitleContentVO(content: title ?? "")
    }
}
