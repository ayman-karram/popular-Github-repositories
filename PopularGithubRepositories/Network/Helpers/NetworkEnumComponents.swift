//
//  NetworkEnumComponents.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 01.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

enum Task {
    case requestPlain
    case requestParameters(Parameters)
}

enum ParametersEncoding {
    case url
    case json
}

enum NetworkServiceResponse<T> {
  case success(T)
  case failure(NetworkError)
}

enum NetworkError {
  case unknown
  case noJSONData
  case JSONDecoder
}
