//
//  RichTextDTO.swift
//  Data
//
//  Created by 최재혁 on 7/11/24.
//

import Foundation
import Domain

enum RichTextType : String, Decodable {
    case text
    case image
}

protocol RichTextDTO : Decodable, EntityRepresentable {
    var type : RichTextType { get }
}

struct TextDTO : RichTextDTO {
    var type: RichTextType = .text
    let text : String?
    let textColor : String?
    let fontSize : Int?
    let background : String?
    let textStyle : [String]?
    
    enum DecodingKeys : String, CodingKey {
        case text
        case textColor
        case fontSize
        case background
        case textStyle
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.textColor = try container.decodeIfPresent(String.self, forKey: .textColor)
        self.fontSize = try container.decodeIfPresent(Int.self, forKey: .fontSize)
        self.background = try container.decodeIfPresent(String.self, forKey: .background)
        self.textStyle = try container.decodeIfPresent([String].self, forKey: .textStyle)
    }
}

struct ImageDTO : RichTextDTO {
    var type: RichTextType = .image
    let url : String?
    let width : Int?
    let height : Int?
    
    enum DecodingKeys : String, CodingKey {
        case url
        case width
        case height
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.width = try container.decodeIfPresent(Int.self, forKey: .width)
        self.height = try container.decodeIfPresent(Int.self, forKey: .height)
    }
}

extension TextDTO : EntityRepresentable {
    func toEntity() -> RichTextable {
        return RichTextContentVO.RTTextVO(
            text: text ?? "",
            textColor: textColor ?? "black",
            fontSize: CGFloat(fontSize ?? 17),
            background: background ?? "clear",
            textStyle: textStyle ?? []
        )
    }
}

extension ImageDTO : EntityRepresentable {
    func toEntity() -> RichTextable {
        return RichTextContentVO.RTImageVO(url: URL(string: url ?? "")!, width: CGFloat(width ?? 30), height: CGFloat(height ?? 30))
    }
}

struct RichTextDTOWrapper: Decodable {
    let text : TextDTO?
    let image : ImageDTO?
    
    enum CodingKeys: String, CodingKey {
        case text
        case image
    }
    
    enum RichTextDTOTypeKeys: String, CodingKey {
        case textDTO
        case imageDTO
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text  = try container.decodeIfPresent(TextDTO.self, forKey: .text)
        self.image = try container.decodeIfPresent(ImageDTO.self, forKey: .image)
    }
}

extension RichTextDTOWrapper : EntityRepresentable {
    func toEntity() -> RichTextable {
        if let text = self.text {
            return text.toEntity()
        }
        
        if let image = self.image {
            return image.toEntity()
        }
        
        return RichTextContentVO.RTTextVO(text: "", textColor: "", fontSize: 17, background: "black", textStyle: [])
    }
}
