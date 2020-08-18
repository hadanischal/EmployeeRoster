//
//  NavigationControllerExtension.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 18/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomStyle()
    }
}

extension UINavigationController {
    func setCustomStyle() {
        navigationBar.isTranslucent = false
        // To tint the bar's items
        navigationBar.tintColor = .titleTintColor
        // To tint the bar's background
        navigationBar.barTintColor = .barTintColor
        //        navigationItem.hidesBackButton = true

        let largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.navigationBarTitleLarge,
            NSAttributedString.Key.foregroundColor: UIColor.titleTintColor
        ]
        navigationBar.largeTitleTextAttributes = largeTitleTextAttributes

        let attributes = [
            NSAttributedString.Key.font: UIFont.navigationBarTitle,
            NSAttributedString.Key.foregroundColor: UIColor.titleTintColor
        ]
        navigationBar.titleTextAttributes = attributes

        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.navigationBarButtonItem], for: UIControl.State.normal)

        view.backgroundColor = .barTintColor
    }

    func configureNavigationBar() {
        navigationBar.barTintColor = UIColor.primary
        navigationBar.isTranslucent = false
        navigationBar.tintColor = UIColor.white

        let largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.navigationBarTitleLarge,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationBar.largeTitleTextAttributes = largeTitleTextAttributes

        let attributes = [
            NSAttributedString.Key.font: UIFont.navigationBarTitle,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationBar.titleTextAttributes = attributes

        let buttonAttributes = [NSAttributedString.Key.font: UIFont.navigationBarButtonItem]

        UIBarButtonItem
            .appearance()
            .setTitleTextAttributes(buttonAttributes,
                                    for: UIControl.State.normal)
    }
}
