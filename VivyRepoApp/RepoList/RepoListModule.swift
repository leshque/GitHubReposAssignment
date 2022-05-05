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
        let presenter = getPresenter()
        let repoVC = RepoListViewController(presenter: presenter, dataSource: RepoListDataSource())
        presenter.view = repoVC
        return UINavigationController(rootViewController: repoVC)
    }
    
    private func getPresenter() -> RepoListPresenter {
        RepoListPresenter(interactor: getInteractor())
    }
    
    private func getInteractor() -> RepoListInteractorProtocol {
        RepoListInteractor(networkClient: getNetworkClient())
    }
    
    private func getNetworkClient() -> NetworkClientProtocol {
        NetworkClient()
    }
    
}

