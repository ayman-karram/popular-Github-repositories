//
//  RepositoriesListViewModelTests.swift
//  PopularGithubRepositoriesTests
//
//  Created by Ayman Karram on 02.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import XCTest
@testable import PopularGithubRepositories

class RepositoriesListViewModelTests: XCTestCase {
    
    func testSuccessFetchRepositories() {
        let networkServer = MockNetworkServerClient()
        let viewModel = RepositoriesListViewModel(networkServerClient: networkServer)
        viewModel.fetchPopularRepositories()
        guard case RepositoriesListState.finishedFetchingPage = viewModel.state.value else {
            XCTFail()
            return
        }
    }

    func testFailFetchRecipes() {
        let networkServer = MockNetworkServerClient()
        networkServer.mockSearchResponse = .failure(NetworkError.unknown)
        let viewModel = RepositoriesListViewModel(networkServerClient: networkServer)
        viewModel.fetchPopularRepositories()
        guard case RepositoriesListState.error(_) = viewModel.state.value else {
            XCTFail()
            return
        }
    }
}

private class MockNetworkServerClient: NetworkServerClient {

    var mockSearchResponse: NetworkServiceResponse<SearchResponse> =  .success(SearchResponse.getMockSearchResponse())

    override func getPopularRopositories(service: ServiceProtocol,
                                         completion: @escaping (NetworkServiceResponse<SearchResponse>) -> ()) {
        completion(mockSearchResponse)
    }
}
