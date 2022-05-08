//
//  RepoListModule.swift
//  VivyRepoApp
//
//  Created by Aliaksei Prokharau on 05.05.22.
//

import Foundation
import UIKit

protocol RepoListModuleProtocol {
    
    func getView() -> UINavigationController
    
}

class RepoListModule: RepoListModuleProtocol {
    
    func getView() -> UINavigationController {
        let repoVC = RepoListViewController(presenter: presenter, dataSource: RepoListDataSource())
        presenter.view = repoVC
        let navController = UINavigationController(rootViewController: repoVC)
        navController.view.backgroundColor = .orange
        return navController
    }
    
    lazy var presenter: RepoListPresenter = {
        RepoListPresenter(interactor: interactor)
    }()
    
    lazy var interactor: RepoListInteractorProtocol = {
        RepoListInteractor(networkClient: networkClient)
    }()
    
    lazy var networkClient: NetworkClientProtocol = {
        NetworkClient()
    }()
    
}

