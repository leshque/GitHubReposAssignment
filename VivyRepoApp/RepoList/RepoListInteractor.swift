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
                self.fetchBranchesCount(for: repositories) { branchesCountDict in
                    let repositoriesDTO = RepoListInteractor.repositoriesDTO(
                        from: repositories,
                        branchesCountDict: branchesCountDict
                    )
                    
                    for repo in repositoriesDTO.repositories {
                        print("repo: \(repo.name), branchesCount: \(repo.branchesCount)")
                    }
                    completion(.success(repositoriesDTO))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func repositoriesDTO(from repositories: RepositoriesCodable, branchesCountDict: [String: Int]) -> RepositoriesDTO {
        RepositoriesDTO(
            repositories: repositories.items.map {
                RepositoryDTO(
                    name: $0.full_name,
                    forksCount: $0.forks_count,
                    branchesCount: branchesCountDict[$0.full_name] ?? 0
                )
            }
        )
    }
    
    private func fetchBranchesCount(for repositories: RepositoriesCodable, completion: @escaping ([String: Int]) -> ()) {
        let calcQueue = DispatchQueue(label: "branchesFetchQueue", attributes: .concurrent)
        let group = DispatchGroup()
        var branchesInfo = [String: Int]() // full_name : branchesCount
        
        for repo in repositories.items {
            group.enter()
            self.networkClient.getBranches(repoFullName: repo.full_name) { result in
                switch result {
                case .success(let branches):
                    calcQueue.async(flags: .barrier) {
                        branchesInfo[repo.full_name] = branches.count
                        group.leave()
                    }
                case .failure(_):
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            completion(branchesInfo)
        }
    }
    
        /*
         
         func first(completion: @escaping (Int) -> Void) {
           DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(randomTime)) {
             completion(1)
           }
         }

         
         let calcQueue = DispatchQueue(label: "calculationQueue", attributes: .concurrent)
             let group = DispatchGroup()
             var numbers = [Int]()

             let numberProviders = [
                 first,
                 second,
                 third,
                 fourth
             ]

             for provider in numberProviders {
                 group.enter()
                 provider { number in
                     calcQueue.async(flags: .barrier) {
                         numbers.append(number)
                         group.leave()
                     }
                 }
             }

             group.notify(queue: .main) {
                 let result = numbers.reduce(0) {
                     $0 + $1
                 }
                 completion(result)
             }

         
         */
    
}
