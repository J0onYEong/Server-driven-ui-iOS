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
    func toEntity() -> ViewContentVO {
        return ViewContentVO(
            viewType: "BViewType",
            content: [
                TitleContentVO(content: title ?? "")
            ]
        )
    }
}
