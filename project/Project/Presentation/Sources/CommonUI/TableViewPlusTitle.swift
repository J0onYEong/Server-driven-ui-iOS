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
    public static let cellID = "TableViewTitleCell"
    let superView = UIView()
    let firstRowImage = UIImageView()
    let titleTextLabel = UILabel()
    let starBadgeImage = UIImageView()
    let starBadgeLabel = UILabel()
    let medalImage = UIImageView()
    let medalLable = UILabel()
    let descriptionLabel = UILabel()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initAttribute()
        initUI()
        setLayout()
    }

    public func bind(plusTitleSectionVO : PlusTitleSectionVO) {

    }

    func initAttribute() {
        superView.translatesAutoresizingMaskIntoConstraints = false
        firstRowImage.translatesAutoresizingMaskIntoConstraints = false
        titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        starBadgeImage.translatesAutoresizingMaskIntoConstraints = false
        starBadgeLabel.translatesAutoresizingMaskIntoConstraints = false
        medalImage.translatesAutoresizingMaskIntoConstraints = false
        medalLable.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    func initUI() {
        contentView.addSubview(superView)
        superView.addSubview(firstRowImage)
        superView.addSubview(titleTextLabel)
        superView.addSubview(starBadgeImage)
        superView.addSubview(starBadgeLabel)
        superView.addSubview(medalImage)
        superView.addSubview(medalLable)
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
            firstRowImage.topAnchor.constraint(equalTo: superView.topAnchor, constant: 10),
            firstRowImage.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 5),
        ])

        NSLayoutConstraint.activate([
            titleTextLabel.topAnchor.constraint(equalTo: firstRowImage.bottomAnchor, constant: 10),
            titleTextLabel.leadingAnchor.constraint(equalTo: firstRowImage.leadingAnchor),
            titleTextLabel.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 5)
        ])

        NSLayoutConstraint.activate([
            starBadgeImage.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant: 5),
            starBadgeImage.leadingAnchor.constraint(equalTo: firstRowImage.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            starBadgeLabel.topAnchor.constraint(equalTo: starBadgeImage.topAnchor),
            starBadgeLabel.leadingAnchor.constraint(equalTo: starBadgeImage.trailingAnchor, constant: 3),
            starBadgeImage.heightAnchor.constraint(equalToConstant: 5)
        ])

        NSLayoutConstraint.activate([
            medalImage.topAnchor.constraint(equalTo: starBadgeImage.topAnchor),
            medalImage.leadingAnchor.constraint(equalTo: starBadgeLabel.trailingAnchor, constant: 5),
            medalImage.heightAnchor.constraint(equalToConstant: 5)
        ])

        NSLayoutConstraint.activate([
            medalLable.topAnchor.constraint(equalTo: medalImage.topAnchor),
            medalLable.leadingAnchor.constraint(equalTo: medalImage.trailingAnchor, constant: 3)
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: starBadgeImage.bottomAnchor, constant: 3),
            descriptionLabel.leadingAnchor.constraint(equalTo: firstRowImage.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 10)
        ])
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
