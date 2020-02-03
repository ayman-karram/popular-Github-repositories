//
//  RepositoryDetailsCoordinator.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 03.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import UIKit

class RepositoryDetailsCoordinator: Coordinator {

    //MARK:- Variables
    var navigationController: UINavigationController
    var repository: Repository

    //MARK:- Init
    init(navigationController: UINavigationController, repository: Repository) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.tintColor = UIColor.black
        self.repository = repository
    }

    //MARK:- Helpers
    func getViewController() -> UIViewController {
        return RepositoryDetailsViewController()
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
