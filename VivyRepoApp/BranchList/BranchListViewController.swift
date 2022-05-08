//
//  BranchListViewController.swift
//  VivyRepoApp
//
//  Created by Aliaksei Prokharau on 05.05.22.
//

import Foundation
import UIKit

struct BranchListViewModel {
            
    let title: String
    let branches: [BasicCellViewModel]
    
}

protocol BranchListViewProtocol: AnyObject {
    
    func render(viewModel: BranchListViewModel)
    
}

class BranchListViewController: UIViewController, BranchListViewProtocol {
    
    // MARK: Dependencies
    
    let presenter: BranchListPresenterProtocol
    let dataSource: BasicTableDataSourceProtocol
    
    // MARK: UI
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: ViewController Lifecycle
    
    init(presenter: BranchListPresenterProtocol,
         dataSource: BasicTableDataSourceProtocol) {
        self.presenter = presenter
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupView()
        layoutViews()
        presenter.viewDidLoad()
    }
        
    // MARK: Private Methods
    
    private func setupView() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource

        view.addSubview(tableView)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
    }
    
    // MARK: RepoListViewProtocol
    
    func render(viewModel: BranchListViewModel) {
        navigationItem.title = viewModel.title
        dataSource.render(
            tableView: tableView,
            cellViewModels: viewModel.branches
        )
    }
    
}
