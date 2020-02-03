//
//  RepositoryDetailsService.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 03.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import Foundation

class RepositoryDetailsService: ServiceProtocol {

    var path: String

    init(ownerName: String, repositoryName: String) {
        path = ("\(ownerName)/\(repositoryName)")
    }

    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    var paramters: Parameters? {
        return nil
    }

    var method: HTTPMethod {
        return .get
    }

    var task: Task {
        return .requestPlain
    }

    var headers: RequestHeaders? {
        return nil
    }

    var parametersEncoding: ParametersEncoding {
        return .url
    }
}

protocol RepositoryDetailsServiceProtocol {
    func getRepositoryDetails(service: ServiceProtocol,
                                completion: @escaping (_ result: NetworkServiceResponse<Repository>) -> ())
}
