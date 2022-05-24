//
//  AppEnvironment.swift
//  RepoApp
//
//  Created by Aliaksei Prokharau on 08.05.22.
//

import Foundation

class AppEnvironment {
    
    static let shared = AppEnvironment()
    
    lazy var networkClient = NetworkClient()
    
}
