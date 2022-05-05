//
//  RepoListViewController.swift
//  VivyRepoApp
//
//  Created by Aliaksei Prokharau on 05.05.22.
//

import UIKit

struct RepoListViewModel {
    
    enum State {
        case loading
        case error(String)
        case loaded
    }
    
    struct Actions {
        
        let onSearch: (String) -> ()
        
    }
    
    let actions: Actions
    let repos: [RepositoryViewModel]
    
}

struct RepositoryViewModel {
    
    let title: String
    let subtitle: String
    
}

protocol RepoListViewProtocol: AnyObject {
 
    func render(viewModel: RepoListViewModel)
    
}

class RepoListViewController: UIViewController, RepoListViewProtocol {
    
    // MARK: Dependencies
    
    let dataSource: RepoListDataSourceProtocol
    
    // MARK: UI
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.placeholder = "Enter Repo name..."
        return bar
    }()
    
    // MARK: ViewController Lifecycle
    
    init(dataSource: RepoListDataSourceProtocol) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupView()
        layoutViews()
    }
    
    // MARK: Private Properties
    
    var onSearch: (String) -> () = { _ in }
    
    // MARK: Private Methods
    
    private func setupView() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        searchBar.delegate = self

        view.addSubview(tableView)
        navigationItem.titleView = searchBar
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
    
    func render(viewModel: RepoListViewModel) {
        onSearch = viewModel.actions.onSearch
    }

}

extension RepoListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        onSearch(searchText)
        print("searchBar text: \(searchText)")
    }
    
}
