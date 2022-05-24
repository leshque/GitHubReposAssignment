//
//  MockRouter.swift
//  RepoAppTests
//
//  Created by Aliaksei Prokharau on 24.05.22.
//

import Foundation
@testable import RepoApp
import UIKit

class MockRouter: RouterProtocol {
    
    lazy var mockGetInitialView: () -> UINavigationController = {
        return UINavigationController()
    }
    
    lazy var mockOpenRepoDetails: (String) -> Void = { _ in }
    
    func getInitialView() -> UINavigationController {
        mockGetInitialView()
    }
    
    func openRepoDetails(repoName: String) {
        mockOpenRepoDetails(repoName)
    }
    
    
    
    
}
