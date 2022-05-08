//
//  BranchListInteractor.swift
//  VivyRepoApp
//
//  Created by Aliaksei Prokharau on 08.05.22.
//

import Foundation

protocol BranchListInteractorProtocol {
    
    func loadBranches(
        repoName: String,
        completion: @escaping (Result<[BranchDTO], Error>) -> ()
    )
    
}

class BranchListInteractor: BranchListInteractorProtocol {
    
    let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func loadBranches(
        repoName: String,
        completion: @escaping (Result<[BranchDTO], Error>) -> ()
    ) {
        self.networkClient.getBranches(repoFullName: repoName) { result in
            switch result {
            case .success(let branches):
                let branchesDTO = BranchListInteractor.branchesDTO(from: branches)
                completion(.success(branchesDTO))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func branchesDTO(from branches: [BranchCodable]) -> [BranchDTO] {
        branches.map {
            BranchDTO(name: $0.name)
        }
    }

    
}
