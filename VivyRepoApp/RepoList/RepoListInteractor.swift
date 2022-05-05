//
//  RepoListInteractor.swift
//  VivyRepoApp
//
//  Created by Aliaksei Prokharau on 05.05.22.
//

import Foundation

protocol RepoListInteractorProtocol {
    
    func loadRepos(
        query: String,
        completion: @escaping (Result<RepositoriesDTO, Error>) -> ()
    )
    
}

class RepoListInteractor: RepoListInteractorProtocol {
    
    let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func loadRepos(
        query: String,
        completion: @escaping (Result<RepositoriesDTO, Error>) -> ()
    ) {
        networkClient.getRepos(
            query: query
        ) { result in
            switch result {
            case .success(let repositories):
                completion(.success(RepoListInteractor.repositoriesDTO(from: repositories)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func repositoriesDTO(from repositories: RepositoriesCodable) -> RepositoriesDTO {
        RepositoriesDTO(
            repositories: repositories.items.map {
                RepositoryDTO(
                    name: $0.full_name,
                    forksCount: $0.forks_count
                )
            }
        )
    }
    
}
