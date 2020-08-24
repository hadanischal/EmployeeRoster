//
//  BaseViewProtocol.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 15/8/20.
//  Copyright © 2020 NischalHada. All rights reserved.
//

import PKHUD
import RxCocoa
import RxSwift
import UIKit

protocol BaseViewProtocol: AnyObject {
    func startAnimating()
    func stopAnimating()
    var isAnimating: Binder<Bool> { get }
}

extension BaseViewProtocol {
    /// Add the spinner in view controller
    func startAnimating() {
        HUD.show(.progress)
    }

    /// Remove the spinner in view controller
    func stopAnimating() {
        HUD.hide()
    }

    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    var isAnimating: Binder<Bool> {
        return Binder(self) { activityIndicator, active in
            if active {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }
}
