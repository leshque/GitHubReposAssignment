//
//  BranchListModule.swift
//  RepoApp
//
//  Created by Aliaksei Prokharau on 08.05.22.
//

import Foundation
import UIKit

protocol BranchListModuleProtocol {
    
    func getView(repoName: String) -> UIViewController
    
}

class BranchListModule: BranchListModuleProtocol {
    
    func getView(repoName: String) -> UIViewController {
        let presenter = presenter(repoName: repoName)
        let branchesVC = BranchListViewController(
            presenter: presenter,
            dataSource: BasicTableDataSource()
        )
        presenter.view = branchesVC
        return branchesVC
    }
    
    func presenter(repoName: String) -> BranchListPresenter {
        BranchListPresenter(
            repoName: repoName,
            interactor: interactor()
        )
    }
    
    func interactor() -> BranchListInteractorProtocol {
        BranchListInteractor(networkClient: AppEnvironment.shared.networkClient)
    }
    
}
