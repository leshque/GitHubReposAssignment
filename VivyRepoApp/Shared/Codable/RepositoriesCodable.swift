//
//  RepositoriesCodable.swift
//  VivyRepoApp
//
//  Created by Aliaksei Prokharau on 05.05.22.
//

import Foundation

struct RepositoriesCodable: Codable {
    
    let items: [RepositoryCodable]
    
}

struct RepositoryCodable: Codable {
    
    let full_name: String
    let forks_count: Int
    
}
