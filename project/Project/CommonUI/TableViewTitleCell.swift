//
//  TableViewCell.swift
//  App
//
//  Created by 최재혁 on 7/3/24.
//

import UIKit
import Domain

open class TableViewTitleCell : UITableViewCell {
    public static let cellID = "TableViewTitleCell"
    let superView = UIView()
    let titleLabel = UILabel()
    let badgeImage = UIImageView()
    let badgeLabel = UILabel()
    let descriptionLabel = UILabel()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initAttribute()
        initUI()
        setLayout()
    }
    
    public func bind(titleSectionVO : TitleSectionVO) {
        
    }
    
    func initAttribute() {
        superView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeImage.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        
        badgeLabel.font = UIFont.systemFont(ofSize: 13)
        badgeLabel.textColor = .gray
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = .gray
    }
    
    func initUI() {
        contentView.addSubview(superView)
        superView.addSubview(titleLabel)
        superView.addSubview(badgeImage)
        superView.addSubview(badgeLabel)
        superView.addSubview(descriptionLabel)
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            superView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            superView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            superView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            superView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: superView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            badgeImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            badgeImage.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            badgeImage.heightAnchor.constraint(equalToConstant: 5)
        ])
        
        NSLayoutConstraint.activate([
            badgeLabel.leadingAnchor.constraint(equalTo: badgeImage.trailingAnchor, constant: 3),
            badgeLabel.topAnchor.constraint(equalTo: badgeImage.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: badgeImage.bottomAnchor, constant: 3),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 10)
        ])
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
