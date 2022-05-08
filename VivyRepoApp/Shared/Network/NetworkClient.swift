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
    case parsing
    
}

protocol NetworkClientProtocol {
    
    func getRepos(
        query: String,
        completion: @escaping (Result<RepositoriesCodable, Error>) -> ()
    )

    func getBranches(
        repoFullName: String,
        completion: @escaping (Result<[BranchCodable], Error>) -> ()
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
    
    func getBranches(
        repoFullName: String,
        completion: @escaping (Result<[BranchCodable], Error>) -> ()
    ) {
        request(.branches(repoFullName: repoFullName)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    if let branches = try? decoder.decode([BranchCodable].self, from: data) {
                        completion(.success(branches))
                    } else {
                        completion(.failure(NetworkError.parsing))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func request(
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
