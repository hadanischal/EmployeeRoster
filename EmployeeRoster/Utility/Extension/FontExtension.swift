//
//  FontExtension.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 18/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

extension UIFont {
    static func boldFont(size: CGFloat) -> UIFont { UIFont(font: FontFamily.GothamRounded.bold, size: size) }

    static func regularFont(size: CGFloat) -> UIFont { UIFont(font: FontFamily.GothamRounded.medium, size: size) }

    static func lightFont(size: CGFloat) -> UIFont { UIFont(font: FontFamily.GothamRounded.light, size: size) }
}

extension UIFont {
    static var navigationBarTitle: UIFont { .lightFont(size: 24) }

    static var navigationBarTitleLarge: UIFont { .regularFont(size: 35) }

    static var navigationBarButtonItem: UIFont { .lightFont(size: 20) }

    static var heading1: UIFont { .regularFont(size: 25) }

    // city list view
    static var body1: UIFont { .regularFont(size: 20) }

    // city search
    static var body2: UIFont { .lightFont(size: 20) }

    // city search
    static var body3: UIFont { .regularFont(size: 18) }

    static var detailTitle: UIFont { .lightFont(size: 16) }

    static var detailBody: UIFont { .regularFont(size: 24) }

    static var imageTitle: UIFont { .boldFont(size: 40) }
}
