//
//  MockRepoListView.swift
//  RepoAppTests
//
//  Created by Aliaksei Prokharau on 08.05.22.
//

import Foundation
@testable import RepoApp

class MockRepoListView: RepoListViewProtocol {
    
    var mockRender: (RepoListViewModel) -> () = { _ in }
    
    var mockPresentDetails: (String) -> () = { _ in }
    
    func render(viewModel: RepoListViewModel) {
        mockRender(viewModel)
    }
    
    func presentDetails(repoName: String) {
        mockPresentDetails(repoName)
    }
    
}
