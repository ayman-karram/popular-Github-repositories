//
//  Alert.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 03.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import Foundation

struct AlertAction {
    let buttonTitle: String
    let handler: (() -> Void)?
}

struct SingleButtonAlert {
    let title: String
    let message: String?
    let action: AlertAction
}
