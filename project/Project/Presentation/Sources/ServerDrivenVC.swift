//
//  ServerDrivenVC.swift
//  App
//
//  Created by 최재혁 on 7/4/24.
//

import Foundation
import Domain
import RxSwift
import UIKit

public class ServerDrivenVC : UIViewController {
    private var disposebag = DisposeBag()
    private var viewModel : ServerDrivenProtocol!
    private var screenVO : ScreenVO!
    private var contents : [SectionComponentVO] = []
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupDelegate()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(viewModel : ServerDrivenProtocol) {
        self.viewModel = viewModel
        
        self.rx.viewDidLoad.bind(to: viewModel.viewDidLoad)
            .disposed(by: disposebag)
        
        self.viewModel.cellInformation
            .emit(onNext: { [weak self] screenVO in
                self?.screenVO = screenVO
                self?.contents = screenVO.contents
                self?.tableView.reloadData()
            })
            .disposed(by: disposebag)
    }
    
    public func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    public func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    public func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private let tableView : TableView = {
        let table = TableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
}

extension ServerDrivenVC : UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = contents[indexPath.row]
        switch component.type {
        case .title :
            if let tileComponent = component as? TitleSectionVO {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewTitleCell.cellID, for : indexPath) as! TableViewTitleCell
                cell.bind(titleSectionVO: tileComponent)
                return cell
            }
        case .title_plus :
            if let tilePlusComponent = component as? PlusTitleSectionVO {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewPlusTitleCell.cellID, for : indexPath) as! TableViewPlusTitleCell
                cell.bind(plusTitleSectionVO : tilePlusComponent)
                return cell
            }
        }
        
        return UITableViewCell()
    }
}
