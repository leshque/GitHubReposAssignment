//
//  BranchListPresenter.swift
//  VivyRepoApp
//
//  Created by Aliaksei Prokharau on 08.05.22.
//

import Foundation

protocol BranchListPresenterProtocol {
    
    func viewDidLoad()
    
}

class BranchListPresenter: BranchListPresenterProtocol {
    
    weak var view: BranchListViewProtocol?
    let interactor: BranchListInteractorProtocol
    let repoName: String
    
    init(
        repoName: String,
        interactor: BranchListInteractorProtocol
    ) {
        self.repoName = repoName
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.loadBranches(repoName: repoName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let branches):
                let viewModel = self.viewModel(from: branches)
                self.view?.render(viewModel: viewModel)
            case .failure(_):
                let viewModel = self.errorViewModel()
                self.view?.render(viewModel: viewModel)
            }
        }
        
    }
    
}

extension BranchListPresenter {
    
    func viewModel(from branches: [BranchDTO]) -> BranchListViewModel {
        return BranchListViewModel(
            title: repoName,
            branches: branches.map {
                return BasicCellViewModel(
                    title: "\($0.name)",
                    onTap: { }
                )
            }
        )
    }
    
    func errorViewModel() -> BranchListViewModel {
        BranchListViewModel(
            title: repoName,
            branches: [
                BasicCellViewModel(title: "Failed to load branches", onTap: { })
            ]
        )
    }
    
}
