//
//  RepositoryDetailsViewModel.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 03.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import Foundation

class RepositoryDetailsViewModel {

    //MARK:- Properties
    private (set) var state: Bindable<FetchingServiceState> = Bindable(.loading)
    private let networkServerClient: NetworkServerClient
    private var repository: Bindable<Repository?>
    private let refreshTime = 10 // Refreshing time in seconds
    private var refreshServiceTimer: Timer?

    //MARK:- init
    //init RepositoriesListViewModel with dependency injection of network server client object
    //to be able to mock the network layer for unit testing
    init(networkServerClient: NetworkServerClient = NetworkServerClient(),
         repository: Repository) {
        self.networkServerClient = networkServerClient
        self.repository = Bindable(repository)
        startRefreshTimer()
    }

    deinit {
        refreshServiceTimer?.invalidate()
    }

    //MARK:- Helpers
    func fetchRepositoryDetails(){
        guard let ownerName = repository.value?.owner.login, let repositoryName = repository.value?.name else {return}
        state.value = .loading
        networkServerClient.getRepositoryDetails(service: RepositoryDetailsService(ownerName: ownerName, repositoryName: repositoryName),
                                                 completion: {[weak self] response in
                                                    self?.state.value = .finishedLoading
                                                    switch response {
                                                    case .success(let repository):
                                                        self?.repository.value = repository
                                                    case .failure(let error):
                                                        self?.state.value = .error(error)
                                                    }
        })
    }

    private func startRefreshTimer(){
        self.refreshServiceTimer = Timer(timeInterval: TimeInterval(refreshTime), repeats: true, block: { [weak self] _ in
            self?.fetchRepositoryDetails()
        })
    }
}
