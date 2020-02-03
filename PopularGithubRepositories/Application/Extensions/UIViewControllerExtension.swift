//
//  UIViewControllerExtension.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 03.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import UIKit

protocol SingleButtonDialogPresenter {
    func presentSingleButtonDialog(alert: SingleButtonAlert)
}

extension UIViewController:  SingleButtonDialogPresenter {
    func presentSingleButtonDialog(alert: SingleButtonAlert) {
        let alertController = UIAlertController(title: alert.title,
                                                message: alert.message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: alert.action.buttonTitle,
                                                style: .default,
                                                handler: { _ in alert.action.handler?() }))
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
