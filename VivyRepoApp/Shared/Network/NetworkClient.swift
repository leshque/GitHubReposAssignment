//
//  NetworkClient.swift
//  VivyRepoApp
//
//  Created by Aliaksei Prokharau on 05.05.22.
//

import Foundation

enum NetworkError: Error {
    
    case invalidURL
    case network(Error)
    case unknown
    
}

protocol NetworkClientProtocol {
    
    func getRepos(
        query: String,
        completion: @escaping (Result<RepositoriesCodable, Error>) -> ()
    )

}

class NetworkClient: NetworkClientProtocol {
    
    lazy var urlSession = URLSession.shared
    
    func getRepos(
        query: String,
        completion: @escaping (Result<RepositoriesCodable, Error>) -> ()
    ) {
        request(.search(query: query)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    if let repositories = try? decoder.decode(RepositoriesCodable.self, from: data) {
                        completion(.success(repositories))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func request(
        _ endpoint: Endpoint,
        completion: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        guard let url = endpoint.url else {
            return completion(.failure(NetworkError.invalidURL))
        }
        let task = urlSession.dataTask(with: url) {
            data, _, error in
            
            let result = data.map(Result.success) ??
                .failure(NetworkError.network(error ?? NetworkError.unknown))
            completion(result)
        }
        task.resume()
    }
    
}
