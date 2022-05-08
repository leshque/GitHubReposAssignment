//
//  RepoListPresenter.swift
//  VivyRepoApp
//
//  Created by Aliaksei Prokharau on 05.05.22.
//

import Foundation

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
    
    private var workItem: DispatchWorkItem?
    
    lazy var onSearch: (String) -> () = { [weak self] query in
        guard let self = self else { return }
        
        // Cancelling the API call if user input has changed within 0.5 second
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
    
    private func searchRepos(
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
                let viewModel = self.errorViewModel()
                self.view?.render(viewModel: viewModel)
            }
        }
    }
 
    func openRepoDetails(name: String) {
        print("wants to open repo details: \(name)")
        view?.presentDetails(repoName: name)
    }
}

extension RepoListPresenter {
    
    func viewModel(from repositories: RepositoriesDTO) -> RepoListViewModel {
        return RepoListViewModel(
            actions: RepoListViewModel.Actions(onSearch: onSearch),
            repos: repositories.repositories.map {
                let branchCountText = branchCountText($0.branchCount)
                let name = $0.name
                return BasicCellViewModel(
                    title: "\($0.name) (\(branchCountText))",
                    onTap: { [weak self] in
                        guard let self = self else { return }
                        self.openRepoDetails(name: name)
                    }
                )
            }
        )
    }
    
    private func branchCountText(_ branchCount: Int) -> String {
        switch branchCount {
        case -1:
            return "Error"
        case 100:
            return "100+? branches"
        default:
            return "\(branchCount) branches"
        }

    }
    
    func initialViewModel() -> RepoListViewModel {
        RepoListViewModel(actions: RepoListViewModel.Actions(onSearch: onSearch), repos: [])
    }
    
    func errorViewModel() -> RepoListViewModel {
        RepoListViewModel(actions: RepoListViewModel.Actions(onSearch: onSearch), repos: [BasicCellViewModel(title: "Error fetching Repos", onTap: { })])
    }
    
}
