//
//  Router.swift
//  RepoApp
//
//  Created by Aliaksei Prokharau on 24.05.22.
//

import Foundation
import UIKit

protocol RouterProtocol: AnyObject {
    
    func getInitialView() -> UINavigationController
    func openRepoDetails(repoName: String)
    
}

class MainRouter: RouterProtocol {
    
    private var navController: UINavigationController?
    
    func getInitialView() -> UINavigationController {
        let module = RepoListModule()
        let navController = UINavigationController(
            rootViewController: module.getView(router: self)
        )
        self.navController = navController
        return navController
    }
    
    func openRepoDetails(repoName: String) {
        let branchListView = BranchListModule().getView(repoName: repoName)
        navController?.pushViewController(branchListView, animated: true)
    }
    
}
