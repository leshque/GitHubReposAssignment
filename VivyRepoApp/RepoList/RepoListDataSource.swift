//
//  RepoListDataSource.swift
//  VivyRepoApp
//
//  Created by Aliaksei Prokharau on 05.05.22.
//

import UIKit

protocol RepoListDataSourceProtocol: UITableViewDataSource, UITableViewDelegate {
    
    func render()
    
}

class RepoListDataSource: NSObject, RepoListDataSourceProtocol {
    
    func render() {
        
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
