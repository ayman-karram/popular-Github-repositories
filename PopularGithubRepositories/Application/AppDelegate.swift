//
//  AppDelegate.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 01.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var repositoriesListCoordinator: RepositoriesListCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        repositoriesListCoordinator = RepositoriesListCoordinator(navigationController: UINavigationController())
        repositoriesListCoordinator?.show()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = repositoriesListCoordinator?.navigationController
        window?.makeKeyAndVisible()

        return true
    }

}

