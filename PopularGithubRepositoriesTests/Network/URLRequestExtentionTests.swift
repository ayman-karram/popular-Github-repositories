//
//  URLRequestExtentionTests.swift
//  PopularGithubRepositoriesTests
//
//  Created by Ayman Karram on 01.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import XCTest
@testable import PopularGithubRepositories

class URLRequestExtentionTests: XCTestCase {
    func testInit() {
        let parameters = ["MockParamter": "value"]
        let mockService = MockService(paramters: parameters)
        let urlRequest = URLRequest(service: mockService)
        let urlStringWithParmaters = "https://MockService/ios?MockParamter=value"
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?.first?.key, mockService.headers?.keys.first)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?.first?.value, mockService.headers?.values.first)
        XCTAssertEqual(urlRequest.httpMethod, mockService.method.rawValue)
        XCTAssertEqual(urlRequest.url?.absoluteString, urlStringWithParmaters)
    }
}
