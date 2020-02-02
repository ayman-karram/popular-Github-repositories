//
//  RepositoriesListViewModel.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 02.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import Foundation

enum RepositoriesListState {
    case loading
    case finishedLoading
    case error(NetworkError?)
}

class RepositoriesListViewModel {

    //MARK:- Properties
    private (set) var state: Bindable<RepositoriesListState> = Bindable(.loading)
    private let networkServerClient: NetworkServerClient
    private var searchResponse: SearchResponse?
    private (set) var repositoriesCellsViewModels: Bindable<[RepositoryCellViewModel]> = Bindable([])

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
}
