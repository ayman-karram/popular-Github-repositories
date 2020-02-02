//
//  PopularRepositoriesService.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 01.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import Foundation

class PopularRepositoriesService: ServiceProtocol {

    var paramters: Parameters?

    init(paramters: Parameters?) {
        self.paramters = paramters
    }

    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    var path: String {
        return "/search/repositories"
    }

    var method: HTTPMethod {
        return .get
    }

    var task: Task {
        return .requestParameters(self.paramters ?? [:])
    }

    var headers: RequestHeaders? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
}

protocol PopularRepositoriesServiceProtocol {
    func getPopularRopositories(service: ServiceProtocol,
                                completion: @escaping (_ result: NetworkServiceResponse<SearchResponse>) -> ())
}
