//
//  RichTextViewController.swift
//  Presentation
//
//  Created by choijunios on 7/12/24.
//

import UIKit
import Domain
import RxSwift

public class RichTextViewController: UIViewController {
    
    let viewModel: RichTextViewModel

    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 44.0
        view.register(ViewTypeCell.self, forCellReuseIdentifier: String(describing: ViewTypeCell.self))
        return view
    }()
    
    private let disposeBag = DisposeBag()
    
    public init(viewModel: RichTextViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setAutoLayout()
        setObservable()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getData()
        
        view.backgroundColor = .white
    }
    
    public func setAutoLayout() {
        [
            tableView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    public func setObservable() {

        viewModel
            .voPublisher
            .map({ vo in
                return vo.contents
            })
            .bind(to: tableView.rx.items) { (tableView: UITableView, index: Int, item: ViewContentVO) -> UITableViewCell in
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ViewTypeCell.self)) as? ViewTypeCell else { fatalError() }
                
                let viewModel = ViewTypeCellViewModel(vo: item)
                
                cell.bind(viewModel: viewModel)
                
                return cell
            }
            .disposed(by: disposeBag)
    }
}
