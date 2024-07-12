//
//  ViewTypeCell.swift
//  Presentation
//
//  Created by choijunios on 7/12/24.
//

import UIKit
import Domain

class ViewTypeCell: UITableViewCell {
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 4
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func prepareForReuse() {
        stackView.arrangedSubviews.forEach { view in
            view.constraints.forEach { $0.isActive = false }
            
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    func bind(viewModel: ViewTypeCellViewModel) {
        
        let contents = viewModel.getContents()
        
        contents.forEach { content in
            
            switch content.type {
            case .title:
                guard let vo = content as? TitleContentVO else { return }
                createTitleContentView(vo)
            case .icon:
                guard let vo = content as? IconContentVO else { return }
                createIconContentView(vo)
            case .richText:
                guard let vo = content as? RichTextContentVO else { return }
                createRichTextContentView(vo)
            }
        }
    }
}

extension ViewTypeCell {
    
    func createTitleContentView(_ vo: TitleContentVO) {
        let view = UILabel()
        view.text = vo.content
        stackView.addArrangedSubview(view)
    }
    
    func createIconContentView(_ vo: IconContentVO) {
        
        let view = UIImageView()
        view.load(url: vo.imageUrl)
        view.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(view)
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 56),
            view.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    func createRichTextContentView(_ vo: RichTextContentVO) {
        
        let contents = vo.content
        let richText = NSMutableAttributedString()
        contents.forEach { richTextable in
            let str = richTextable.toString()
            richText.append(str)
        }
        let view = UILabel()
        view.attributedText = richText
        stackView.addArrangedSubview(view)
    }
}

extension RichTextable {
    
    func toString() -> NSAttributedString {
        
        func textToColor(colorStr: String) -> UIColor {
            
            switch colorStr {
            case "clear":
                return .clear
            case "yellow":
                return .yellow
            case "red":
                return .red
            case "black":
                return .black
            default:
                return .clear
            }
        }
        
        switch type {
        case .text:
            guard let vo = self as? RichTextContentVO.RTTextVO else { return .init() }
            var attributes: [NSAttributedString.Key: Any] = [:]
            
            let text = vo.text
            let fontSize = vo.fontSize
            attributes[.font] = UIFont.systemFont(ofSize: fontSize)
            
            let textColor = textToColor(colorStr: vo.textColor)
            
            attributes[.foregroundColor] = textColor
            
            let backgroundColor = textToColor(colorStr: vo.background)
            
            attributes[.backgroundColor] = backgroundColor
            
            vo.textStyle.forEach { style in
                switch style {
                case "underline":
                    attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
                    attributes[.underlineColor] = UIColor.black
                default:
                    break
                }
            }
            return .init(string: text, attributes: attributes)
            
        case .image:
            guard let vo = self as? RichTextContentVO.RTImageVO else { return .init() }
            guard let data = try? Data(contentsOf: vo.url), let image = UIImage(data: data) else { return .init() }
            let imageSize = CGSize(width: vo.width, height: vo.height)
            let resizedImage = image.resize(to: imageSize)
            let attachment = NSTextAttachment(image: resizedImage)
            
            return .init(attachment: attachment)
        }
    }
    
}

extension UIImage {
    func resize(to targetSize: CGSize) -> UIImage {
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        let scaleFactor = min(widthRatio, heightRatio)

        let scaledImageSize = CGSize(width: self.size.width * scaleFactor, height: self.size.height * scaleFactor)

        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        }
    }
}
