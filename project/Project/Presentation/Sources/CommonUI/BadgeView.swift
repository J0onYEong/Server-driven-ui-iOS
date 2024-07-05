//
//  BadgeView.swift
//  App
//
//  Created by 최재혁 on 7/5/24.
//

import UIKit
import Domain

class TitlBadgeView: UIView {
    
    let badgeVO: TitleSectionVO.Badge
    
    let label = UILabel()
    let image = UIImageView()
    
    let stack: UIStackView = {
        
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 2
        view.alignment = .center
        
        return view
    }()
    
    init(vo: TitleSectionVO.Badge) {
        
        self.badgeVO = vo
        
        super.init(frame: .zero)
        
        self.label.text = vo.text
        
        self.image.load(url: vo.badgeImageUrl)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func setLayout() {
        
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stack)
        
        [
            image,
            label
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
            image.widthAnchor.constraint(equalTo: label.heightAnchor),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
        ])
    }
}


class PlusTitlBadgeView: UIView {
    
    let badgeVO: PlusTitleSectionVO.Badge
    
    let label = UILabel()
    let image = UIImageView()
    
    let stack: UIStackView = {
        
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 2
        view.alignment = .center
        
        return view
    }()
    
    init(vo: PlusTitleSectionVO.Badge) {
        
        self.badgeVO = vo
        
        super.init(frame: .zero)
        
        self.label.text = vo.text
        
        self.image.load(url: vo.badgeImageUrl)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func setLayout() {
        
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stack)
        
        [
            image,
            label
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
            image.widthAnchor.constraint(equalTo: label.heightAnchor),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
        ])
    }
}
