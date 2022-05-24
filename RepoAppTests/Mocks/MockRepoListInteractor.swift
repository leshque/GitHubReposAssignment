//
//  MockRepoListInteractor.swift
//  RepoAppTests
//
//  Created by Aliaksei Prokharau on 08.05.22.
//

import Foundation
@testable import RepoApp

class MockRepoListInteractor: RepoListInteractorProtocol {
    
    var mockLoadRepos: (String, (Result<RepositoriesDTO, Error>) -> ()) -> () = { _, _ in }
    
    func loadRepos(
        query: String,
        completion: @escaping (Result<RepositoriesDTO, Error>) -> ()
    ) {
        mockLoadRepos(query, completion)
    }
    
}
