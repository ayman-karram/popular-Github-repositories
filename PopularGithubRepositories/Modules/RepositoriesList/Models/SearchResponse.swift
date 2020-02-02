//
//  SearchResponse.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 01.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {

    var totalCount: Double
    var repositories: [Repository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case repositories = "items"
    }
}
