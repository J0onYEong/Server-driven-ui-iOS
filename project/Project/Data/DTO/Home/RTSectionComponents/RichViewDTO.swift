//
//  RichViewDTO.swift
//  Data
//
//  Created by 최재혁 on 7/11/24.
//

import Foundation
import Domain

struct RichViewDTO : Decodable {
    let title : String?
    let richText : [RichTextDTOWrapper]?
    
    enum DecodingKeys : String, CodingKey {
        case title
        case richText
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.richText = try container.decodeIfPresent([RichTextDTOWrapper].self, forKey: .richText)
    }
}

extension RichViewDTO : EntityRepresentable {
    func toEntity() -> ViewContentVO {
        let contents = richText?.map { $0.toEntity() } ?? []
        return ViewContentVO(
            viewType: "RichViewType",
            content: [
                TitleContentVO(content: title ?? ""),
                RichTextContentVO(content: contents)
            ]
        )
    }
}





