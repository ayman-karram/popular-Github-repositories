//
//  RepositoryDetailsViewModel.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 03.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import Foundation

protocol RepositoryDetailsViewModelDelegate: class {
    func viewModelUpdated(repository: Repository)
}

class RepositoryDetailsViewModel {

    //MARK:- Properties
    private let networkServerClient: NetworkServerClient
    var repository: Bindable<Repository?>
    private let refreshTime = 10 // Refreshing time in seconds
    private var refreshServiceTimer: Timer?
    var delegate: RepositoryDetailsViewModelDelegate?
    
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
        networkServerClient.getRepositoryDetails(service: RepositoryDetailsService(ownerName: ownerName, repositoryName: repositoryName),
                                                 completion: {[weak self] response in
                                                    switch response {
                                                    case .success(let repository):
                                                        self?.repository.value = repository
                                                        self?.delegate?.viewModelUpdated(repository: repository)
                                                    case .failure(_): break
                                                    }
        })
    }

    private func startRefreshTimer(){
        self.refreshServiceTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(refreshTime),
                                                        repeats: true) { [weak self] _ in
                                                            self?.fetchRepositoryDetails()
        }
    }
}
