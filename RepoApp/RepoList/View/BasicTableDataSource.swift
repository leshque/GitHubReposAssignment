//
//  RepoListDataSource.swift
//  RepoApp
//
//  Created by Aliaksei Prokharau on 05.05.22.
//

import UIKit

struct BasicCellViewModel {
    
    let title: String
    let onTap: () -> ()
    
}

protocol BasicTableDataSourceProtocol: UITableViewDataSource, UITableViewDelegate {
    
    func render(tableView: UITableView, cellViewModels: [BasicCellViewModel])
    
}

class BasicTableDataSource: NSObject, BasicTableDataSourceProtocol {
    
    private var items: [BasicCellViewModel] = [BasicCellViewModel]()
    private var tableView: UITableView?
    
    func render(tableView: UITableView, cellViewModels: [BasicCellViewModel]) {
        items = cellViewModels
        self.tableView = tableView
        tableView.dataSource = self
        tableView.reloadData()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = items[indexPath.row].title
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].onTap()
    }
    
}
