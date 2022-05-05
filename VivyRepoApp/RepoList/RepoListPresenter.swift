//
//  RepoListPresenter.swift
//  VivyRepoApp
//
//  Created by Aliaksei Prokharau on 05.05.22.
//

import Foundation

struct RepositoriesDTO {
    
    let repositories: [RepositoryDTO]
    
}

struct RepositoryDTO {
    
    let name: String
    let forksCount: Int
    
}

protocol RepoListPresenterProtocol {

    func viewDidLoad()
    
}

class RepoListPresenter: RepoListPresenterProtocol {
    
    weak var view: RepoListViewProtocol?
    let interactor: RepoListInteractorProtocol
    
    init(
        interactor: RepoListInteractorProtocol
    ) {
        self.interactor = interactor
    }
    
    var workItem: DispatchWorkItem?
    
    lazy var onSearch: (String) -> () = { [weak self] query in
        guard let self = self else { return }
        
        self.workItem?.cancel()
        
        let searchWorkItem = DispatchWorkItem {
            self.searchRepos(query: query) { result in
                switch result {
                case .success(let repositoriesDTO):
                    self.view?.render(viewModel: self.viewModel(from: repositoriesDTO))
                case .failure(_):
                    self.view?.render(viewModel: self.initialViewModel())
                }
            }
        }
        
        self.workItem = searchWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: searchWorkItem)
    }
    
    func viewDidLoad() {
        view?.render(viewModel: initialViewModel())
    }
    
    func searchRepos(
        query: String,
        completion: (Result<RepositoriesDTO, Error>) -> ()
    ) {
        interactor.loadRepos(query: query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let repsDTO):
                let viewModel = self.viewModel(from: repsDTO)
                self.view?.render(viewModel: viewModel)
            case .failure(_):
                let viewModel = self.initialViewModel()
                self.view?.render(viewModel: viewModel)
            }
        }
    }
    
}

extension RepoListPresenter {
    
    func viewModel(from repositories: RepositoriesDTO) -> RepoListViewModel {
        RepoListViewModel(
            actions: RepoListViewModel.Actions(onSearch: onSearch),
            repos: repositories.repositories.map {
                RepositoryViewModel(title: $0.name, subtitle: "\($0.forksCount)")
            }
        )
    }
    
    func initialViewModel() -> RepoListViewModel {
        RepoListViewModel(actions: RepoListViewModel.Actions(onSearch: onSearch), repos: [])
    }
    
}
