//
//  RepositoriesListViewModel.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 02.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import Foundation

enum FetchingServiceState {
    case loading
    case finishedLoading
    case error(NetworkError?)
}

protocol RepositoriesListViewModelDelegate: class {
    func repositoriesListViewModelDidSelect(repository: Repository)
}

class RepositoriesListViewModel {
    
    //MARK:- Properties
    private (set) var state: Bindable<FetchingServiceState> = Bindable(.loading)
    private let networkServerClient: NetworkServerClient
    private var searchResponse: SearchResponse?
    private (set) var repositoriesCellsViewModels: Bindable<[RepositoryCellViewModel]> = Bindable([])
    weak var delegate: RepositoriesListViewModelDelegate?
    
    //MARK:- init
    //init RepositoriesListViewModel with dependency injection of network server client object
    //to be able to mock the network layer for unit testing
    init(networkServerClient: NetworkServerClient = NetworkServerClient()) {
        self.networkServerClient = networkServerClient
    }
    
    //MARK:- Helpers
    func fetchPopularRepositories(){
        let paramters = getPopularRepositoriesParamters()
        state.value = .loading
        networkServerClient.getPopularRopositories(service: PopularRepositoriesService(paramters: paramters),
                                                   completion: {[weak self] response in
                                                    self?.state.value = .finishedLoading
                                                    switch response {
                                                    case .success(let searchResponse):
                                                        self?.searchResponse = searchResponse
                                                        self?.repositoriesCellsViewModels.value = searchResponse.repositories.compactMap { RepositoryCellViewModel(repository: $0)}
                                                    case .failure(let error):
                                                        self?.state.value = .error(error)
                                                    }
        })
    }
    
    private func getPopularRepositoriesParamters() -> Parameters {
        return ["q":"language:Swift", "sort": "stars", "order":"desc"]
    }
    
    func didSelectItemAt(index: Int) {
        if let repository = searchResponse?.repositories[index] {
            self.delegate?.repositoriesListViewModelDidSelect(repository: repository)
        }
    }
    
    func update(repository: Repository) {
        if let searchReposnse = self.searchResponse,
            let index = self.searchResponse?.repositories.firstIndex(where: {$0.id == repository.id}) {
            self.searchResponse?.repositories[index] = repository
            self.repositoriesCellsViewModels.value = searchReposnse.repositories.compactMap {
                RepositoryCellViewModel(repository: $0)}
        }
    }
}
