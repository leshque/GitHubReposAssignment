//
//  Endpoint.swift
//  VivyRepoApp
//
//  Created by Aliaksei Prokharau on 05.05.22.
//

import Foundation

enum Sorting: String {
    
    case numberOfStars = "stars"
    case numberOfForks = "forks"
    case recency = "updated"
    
}

struct Endpoint {
    
    let path: String
    let queryItems: [URLQueryItem]
    
}

extension Endpoint {

    static func search(
        query: String,
        sorting: Sorting = .recency
    ) -> Endpoint {
        return Endpoint(
            path: "/search/repositories",
            queryItems: [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "sort", value: sorting.rawValue)
            ]
        )
    }
    
}

extension Endpoint {

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
    
}
