//
//  RepositoryDetialsViewModelTests.swift
//  PopularGithubRepositoriesTests
//
//  Created by Ayman Karram on 03.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import XCTest

@testable import PopularGithubRepositories

class RepositoryDetialsViewModelTests: XCTestCase {

    func testSuccessFetchRepositories() {
        let networkServer = MockNetworkServerClient()
        let mockRepository = Repository.getMockRepoitory()
        let viewModel = RepositoryDetailsViewModel(networkServerClient: networkServer, repository: mockRepository)
        viewModel.fetchRepositoryDetails()
        guard case FetchingServiceState.finishedLoading = viewModel.state.value else {
            XCTFail()
            return
        }
    }

    func testFailFetchRecipes() {
        let networkServer = MockNetworkServerClient()
        let mockRepository = Repository.getMockRepoitory()
        networkServer.mockRepositoryDetails = .failure(NetworkError.unknown)
        let viewModel = RepositoryDetailsViewModel(networkServerClient: networkServer, repository: mockRepository)
        viewModel.fetchRepositoryDetails()
        guard case FetchingServiceState.error(_) = viewModel.state.value else {
            XCTFail()
            return
        }
    }
}

private class MockNetworkServerClient: NetworkServerClient {

    var mockRepositoryDetails: NetworkServiceResponse<Repository> =  .success(Repository.getMockRepoitory())

    override func getRepositoryDetails(service: ServiceProtocol,
                                         completion: @escaping (NetworkServiceResponse<Repository>) -> ()) {
        completion(mockRepositoryDetails)
    }
}
