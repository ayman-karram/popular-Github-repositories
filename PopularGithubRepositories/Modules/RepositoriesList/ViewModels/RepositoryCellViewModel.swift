//
//  RepositoryCellViewModel.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 02.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import Foundation

class RepositoryCellViewModel {

    static let cellIdentifier = String(describing: RepositoryTableViewCell.self)
    private (set) var name: String?
    private (set) var description: String?
    private (set) var ownerImageURL: URL?

    init(repository: Repository?) {
        guard let repository = repository else {return}
        name = repository.name
        description = repository.description
        ownerImageURL = URL(string: repository.owner.avatarUrl)
    }
}
