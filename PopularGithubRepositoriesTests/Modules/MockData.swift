//
//  MockData.swift
//  PopularGithubRepositoriesTests
//
//  Created by Ayman Karram on 02.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import Foundation
@testable import PopularGithubRepositories

internal extension Owner {
    static func getMockOwner() -> Owner {
        return  Owner(avatarUrl: "https://avatars2.githubusercontent.com/u/484656?v=4",login: "Mock Owner")
    }
}

internal extension Repository {
    static func getMockRepoitory() -> Repository {
        return Repository(id: 1.0, name: "Mock Repo",
                          description: "Mock description",
                          forksCount: 300, stargazersCount: 4000, owner: Owner.getMockOwner())
    }
}

internal extension SearchResponse {
    static func getMockSearchResponse () -> SearchResponse {
        return SearchResponse(repositories: [Repository.getMockRepoitory()])
    }
}
