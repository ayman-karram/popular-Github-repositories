//
//  RepositoriesListCoordinator.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 02.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import UIKit

class RepositoriesListCoordinator: Coordinator {

    //MARK:- Variables
    var navigationController: UINavigationController
    var repositoriesListViewModel = RepositoriesListViewModel()

    //MARK:- Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    //MARK:- Helpers
    func getViewController() -> UIViewController {
        let repositoriesListViewController = RepositoriesListViewController(viewModel: repositoriesListViewModel)
        repositoriesListViewModel.delegate = self
        return repositoriesListViewController
    }

    func show(present: Bool = false) {
        let repositoriesListViewController = getViewController()
        if present {
            repositoriesListViewController.modalTransitionStyle = .crossDissolve
            self.navigationController.viewControllers.last?.present(repositoriesListViewController,
                                                                    animated: true, completion: nil)
        } else {
            self.navigationController.navigationBar.prefersLargeTitles = true
            self.navigationController.pushViewController(repositoriesListViewController, animated: true)
        }
    }
}

//MARK:- RepositoriesListViewModelDelegate
extension RepositoriesListCoordinator: RepositoriesListViewModelDelegate {
    func repositoriesListViewModelDidSelect(repository: Repository) {
        let detailsPageCoordinator = RepositoryDetailsCoordinator(navigationController: self.navigationController,
                                                                  repository: repository)
        detailsPageCoordinator.delegate = self
        detailsPageCoordinator.show()
    }
}

//MARK:- RepositoryDetailsCoordinatorDelegate
extension RepositoriesListCoordinator: RepositoryDetailsCoordinatorDelegate {
    func detailsPageUpdated(repository: Repository) {
        repositoriesListViewModel.update(repository: repository)
    }
}
