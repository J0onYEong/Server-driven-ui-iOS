//
//  TableViewPlusTitle.swift
//  App
//
//  Created by 최재혁 on 7/4/24.
//

import Foundation
import Domain
import UIKit

open class TableViewPlusTitleCell : UITableViewCell {
    public static let cellID = "TableViewPlusTitleCell"
    let superView = UIView()
    let firstRowImage = UIImageView()
    let titleTextLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let mainStack: UIStackView = {
        
        let view = UIStackView()
        
        view.axis = .vertical
        view.alignment = .leading
        
        return view
    }()
    
    let badgeStack: UIStackView = {
        
        let view = UIStackView()
        
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = 4
        
        return view
    }()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initAttribute()
        setLayout()
    }

    public func bind(plusTitleSectionVO : PlusTitleSectionVO) {
        firstRowImage.load(url: plusTitleSectionVO.firstRowImageUrl.imageUrl)
        firstRowImage.heightAnchor.constraint(equalToConstant: plusTitleSectionVO.firstRowImageUrl.height).isActive = true
        firstRowImage.widthAnchor.constraint(equalToConstant: plusTitleSectionVO.firstRowImageUrl.width).isActive = true
        
        // badge
        plusTitleSectionVO.badges.forEach { badge in
            
            let badgeView = PlusTitlBadgeView(vo: badge)
            badgeView.translatesAutoresizingMaskIntoConstraints = false
            
            badgeStack.addArrangedSubview(badgeView)
        }
        
        titleTextLabel.text = plusTitleSectionVO.titleText.text
        let textSize = plusTitleSectionVO.titleText.textSize
        
        switch plusTitleSectionVO.titleText.textStyle {
        case .bold:
            titleTextLabel.font = .boldSystemFont(ofSize: textSize)
        case .italic:
            titleTextLabel.font = .italicSystemFont(ofSize: textSize)
        case .strike:
            titleTextLabel.attributedText = titleTextLabel.text?.strikeThrough()
        }
        
        titleTextLabel.textColor = UIColor(hex: plusTitleSectionVO.titleText.textColor)
        
    
        descriptionLabel.text = plusTitleSectionVO.description
    }

    func initAttribute() {
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStack)
        
        [
            firstRowImage,
            titleTextLabel,
            badgeStack,
            descriptionLabel,
        ].forEach {
            
            $0.translatesAutoresizingMaskIntoConstraints = false
            mainStack.addArrangedSubview($0)
        }
        
        titleTextLabel.numberOfLines = 0
        titleTextLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleTextLabel.textColor = .black
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = .gray
    }

    func setLayout() {
        
        // mainStack
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension String {
    
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

