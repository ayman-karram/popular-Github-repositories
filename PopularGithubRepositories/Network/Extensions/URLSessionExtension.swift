//
//  URLSessionExtension.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 01.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import Foundation

extension URLSession: URLSessionProtocol {
      func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
          return dataTask(with: request, completionHandler: completionHandler)
      }
}
