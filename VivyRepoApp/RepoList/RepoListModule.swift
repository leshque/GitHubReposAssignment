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
        let presenter = presenter()
        let repoVC = RepoListViewController(
            presenter: presenter,
            dataSource: BasicTableDataSource()
        )
        presenter.view = repoVC
        let navController = UINavigationController(rootViewController: repoVC)
        return navController
    }
    
    func presenter() -> RepoListPresenter {
        RepoListPresenter(interactor: interactor())
    }
    
    func interactor() -> RepoListInteractorProtocol {
        RepoListInteractor(networkClient: AppEnvironment.shared.networkClient)
    }
        
}

