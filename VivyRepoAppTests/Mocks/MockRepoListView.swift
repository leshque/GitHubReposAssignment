//
//  MockRepoListView.swift
//  VivyRepoAppTests
//
//  Created by Aliaksei Prokharau on 08.05.22.
//

import Foundation
@testable import VivyRepoApp

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
