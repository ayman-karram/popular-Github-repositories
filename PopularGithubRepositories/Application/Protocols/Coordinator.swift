//
//  Coordinator.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 02.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import UIKit

protocol Coordinator {
    var  navigationController: UINavigationController { get set }
    func getViewController() -> UIViewController
    func show(present: Bool)
}
