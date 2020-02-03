//
//  RepositoryDetailsCoordinator.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 03.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import UIKit

protocol RepositoryDetailsCoordinatorDelegate: class {
    func detailsPageUpdated(repository: Repository)
}

class RepositoryDetailsCoordinator: Coordinator {

    //MARK:- Variables
    var navigationController: UINavigationController
    var repository: Repository
    var delegate: RepositoryDetailsCoordinatorDelegate?

    //MARK:- Init
    init(navigationController: UINavigationController, repository: Repository) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.tintColor = UIColor.black
        self.repository = repository
    }

    //MARK:- Helpers
    func getViewController() -> UIViewController {
        let viewModel = RepositoryDetailsViewModel(repository: repository)
        viewModel.delegate = self
        return RepositoryDetailsViewController(viewModel: viewModel)
    }

    func show(present: Bool = false) {
        let repositoryDetailsViewController = getViewController()
        if present {
            repositoryDetailsViewController.modalTransitionStyle = .crossDissolve
            self.navigationController.viewControllers.last?.present(repositoryDetailsViewController,
                                                                    animated: true, completion: nil)
        } else {
            self.navigationController.navigationBar.prefersLargeTitles = true
            self.navigationController.pushViewController(repositoryDetailsViewController, animated: true)
        }
    }
}

//MARK:- RepositoryDetailsViewModelDelegate
extension RepositoryDetailsCoordinator: RepositoryDetailsViewModelDelegate {
    func viewModelUpdated(repository: Repository) {
        self.delegate?.detailsPageUpdated(repository: repository)
    }
}
