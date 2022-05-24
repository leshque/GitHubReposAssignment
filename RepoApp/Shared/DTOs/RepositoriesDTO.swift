//
//  RepositoriesDTO.swift
//  RepoApp
//
//  Created by Aliaksei Prokharau on 06.05.22.
//

import Foundation

struct RepositoriesDTO {
    
    let repositories: [RepositoryDTO]
    
}

struct RepositoryDTO {
    
    let name: String
    let branchCount: Int
    
}
