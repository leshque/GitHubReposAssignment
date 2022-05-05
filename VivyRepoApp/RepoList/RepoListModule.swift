//
//  RepoListModule.swift
//  VivyRepoApp
//
//  Created by Aliaksei Prokharau on 05.05.22.
//

import Foundation
import UIKit

protocol RepoListModuleProtocol {
    
    func getView() -> UIViewController
    
}

class RepoListModule: RepoListModuleProtocol {
    
    func getView() -> UIViewController {
        let repoVC = RepoListViewController(dataSource: RepoListDataSource())
        return UINavigationController(rootViewController: repoVC)
    }
    
}

