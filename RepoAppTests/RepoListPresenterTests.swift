//
//  RepoListPresenterTests.swift
//  RepoAppTests
//
//  Created by Aliaksei Prokharau on 08.05.22.
//

import Foundation
@testable import RepoApp
import XCTest

class RepoListPresenterTests: XCTestCase {
    
    var presenter: RepoListPresenter!
    var mockRepoListInteractor: MockRepoListInteractor!
    var mockRepoListView: MockRepoListView!
    var mockRouter: MockRouter!
    
    override func setUp() {
        mockRepoListInteractor = MockRepoListInteractor()
        mockRepoListView = MockRepoListView()
        mockRouter = MockRouter()
        presenter = RepoListPresenter(
            interactor: mockRepoListInteractor,
            router: mockRouter
        )
        presenter.view = mockRepoListView
    }
    
    func testWhenViewDidLoadIsCalled_thenRenderCalledWithInitialViewModel() {
        let expectation = self.expectation(description: "view.render is called")
        
        mockRepoListView.mockRender = { viewModel in
            XCTAssertEqual(0, viewModel.repos.count)
            expectation.fulfill()
        }
        
        presenter.viewDidLoad()
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testWhenSearchReposIsCalled_thenInteractorIsCalledWithExpectedQuery() {
        let expectation = self.expectation(description: "interactor.loadRepos is called")
        
        mockRepoListInteractor.mockLoadRepos = { query, _ in
            XCTAssertEqual("test_query", query)
            expectation.fulfill()
        }
        
        presenter.onSearch("test_query")
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testWhenSearchReposIsFailed_thenErrorViewModelIsRendered() {
        let interactorExpectation = self.expectation(description: "interactor.loadRepos is called")
        let viewExpectation = self.expectation(description: "view.render is called")
        
        mockRepoListInteractor.mockLoadRepos = { _, completion in
            completion(.failure(NetworkError.parsing))
            interactorExpectation.fulfill()
        }
        mockRepoListView.mockRender = { viewModel in
            XCTAssertEqual(1, viewModel.repos.count)
            XCTAssertEqual("Error fetching Repos", viewModel.repos[0].title)
            viewExpectation.fulfill()
        }
        presenter.onSearch("asdasd")
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
}
