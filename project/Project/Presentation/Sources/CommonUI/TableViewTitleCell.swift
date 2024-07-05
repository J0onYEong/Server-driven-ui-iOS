//
//  TableViewTitleCell.swift
//  App
//
//  Created by 최재혁 on 7/4/24.
//

import UIKit
import Domain

open class TableViewTitleCell : UITableViewCell {
    public static let cellID = "TableViewTitleCell"
    let titleLabel = UILabel()
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

    public func bind(titleSectionVO : TitleSectionVO) {
        titleLabel.text = titleSectionVO.titleText
        descriptionLabel.text = titleSectionVO.description
        
        titleSectionVO.badges.forEach { badge in
            let badgeView = TitlBadgeView(vo: badge)
            badgeView.translatesAutoresizingMaskIntoConstraints = false
            
            badgeStack.addArrangedSubview(badgeView)
        }
    }

    func initAttribute() {
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStack)
        
        [
            titleLabel,
            badgeStack,
            descriptionLabel,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            mainStack.addArrangedSubview($0)
        }
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black

        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = .gray
    }

    func setLayout() {
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
