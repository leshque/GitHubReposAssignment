//
//  RepoListModule.swift
//  RepoApp
//
//  Created by Aliaksei Prokharau on 05.05.22.
//

import Foundation
import UIKit

protocol RepoListModuleProtocol {
    
    func getView(router: RouterProtocol) -> UIViewController
    
}

class RepoListModule: RepoListModuleProtocol {
    
    func getView(router: RouterProtocol) -> UIViewController {
        let presenter = presenter(router: router)
        let repoVC = RepoListViewController(
            presenter: presenter,
            dataSource: BasicTableDataSource()
        )
        presenter.view = repoVC
        return repoVC
    }
    
    func presenter(router: RouterProtocol) -> RepoListPresenter {
        RepoListPresenter(
            interactor: interactor(),
            router: router
        )
    }
    
    func interactor() -> RepoListInteractorProtocol {
        RepoListInteractor(networkClient: AppEnvironment.shared.networkClient)
    }
        
}

