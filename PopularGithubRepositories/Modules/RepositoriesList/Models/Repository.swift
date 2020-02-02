//
//  Repository.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 01.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import Foundation

struct Repository: Codable {

    var id: Double
    var name: String
    var description: String
    var forksCount: Double
    var stargazersCount: Double
    var owner: Owner

    enum CodingKeys: String, CodingKey {
        case id, name, description, owner
        case forksCount = "forks_count"
        case stargazersCount = "stargazers_count"
    }
}
