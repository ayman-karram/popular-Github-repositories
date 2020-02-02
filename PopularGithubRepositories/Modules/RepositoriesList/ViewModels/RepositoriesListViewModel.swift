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
    case finishedFetchingPage
    case finishFetchingAllPages
    case error(NetworkError?)
}

class RepositoriesListViewModel {

    //MARK:- Properties
    private (set) var state: Bindable<RepositoriesListState> = Bindable(.loading)
    private let networkServerClient: NetworkServerClient
    private var searchResponse: SearchResponse?

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
                                                    switch response {
                                                    case .success(let searchResponse):
                                                        self?.state.value = .finishedFetchingPage
                                                        self?.searchResponse = searchResponse
                                                    case .failure(let error):
                                                        self?.state.value = .error(error)
                                                    }
        })
    }

    private func getPopularRepositoriesParamters() -> Parameters {
        return ["q":"language:Swift", "sort": "stars", "order":"desc"]
    }
}
