//
//  ActivityIndicator.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

class ActivityIndicator {
    weak var appDelegate = UIApplication.shared.delegate
    var parentView: UIView?
    var color: UIColor?

    /*
     If user has set the tintColor, the activityIndicator will have tint color as user set,
     If not, the default tintColor will be set as blackColor
     */

    var tintColor: UIColor? {
        get {
            guard let color = self.color else {
                return UIColor.gray
            }
            return color

        } set {
            self.color = newValue
        }
    }

    /*
     If user has not provided view where activity indicator should pop up.
     The default view will be view of the current rootViewController of window.
     */

    var defaultView: UIView? {
        get {
            if let view = self.parentView {
                return view

            } else {
                return appDelegate?.window??.rootViewController?.view
            }
        }
    }

    var activityIndicatorView: UIActivityIndicatorView? {
        get {
            guard let indicatorView = self.defaultView?.superview?.viewWithTag(1024) as? UIActivityIndicatorView else {
                let activityIndicator              = UIActivityIndicatorView(style: .white)
                activityIndicator.frame            = CGRect.zero
                activityIndicator.center           = (self.defaultView?.center) ?? CGPoint(x: 0, y: 0)
                activityIndicator.hidesWhenStopped = true
                activityIndicator.tag              = 1024
                activityIndicator.color            = self.tintColor
                activityIndicator.startAnimating()
                defaultView?.superview?.addSubview(activityIndicator)
                return activityIndicator
            }
            return indicatorView
        }
    }

    func start() {
        self.activityIndicatorView?.startAnimating()
        self.defaultView?.isUserInteractionEnabled = false
    }

    func stop() {
        self.activityIndicatorView?.stopAnimating()
        self.defaultView?.isUserInteractionEnabled = true
    }

}
