//
//  SpinnerViewController+UIViewControllerExtension.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 17/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

let child = SpinnerViewController()
extension UIViewController {

    func createSpinnerView() {
        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func removeSpinnerView() {
        // wait two seconds to simulate some work happening
        // then remove the spinner view controller
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
