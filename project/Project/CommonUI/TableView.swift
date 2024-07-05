//
//  TableView.swift
//  App
//
//  Created by 최재혁 on 7/3/24.
//

import UIKit

open class TableView : UITableView {
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initAttribute()
    }
    
    func initAttribute() {
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
