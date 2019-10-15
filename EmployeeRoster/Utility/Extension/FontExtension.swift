//
//  FontExtension.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 18/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

extension UIFont {
    class func boldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "GothamRounded-Bold", size: size)!
    }
    class func regularFont(size: CGFloat) -> UIFont {
        return UIFont(name: "GothamRounded-Medium", size: size)!
    }
    class func lightFont(size: CGFloat) -> UIFont {
        return UIFont(name: "GothamRounded-Light", size: size)!
    }
}

extension UIFont {
    static var navigationBarTitle: UIFont {
        return .lightFont(size: 24)
    }
    static var navigationBarTitleLarge: UIFont {
         return .regularFont(size: 35)
     }
    static var navigationBarButtonItem: UIFont {
        return .lightFont(size: 20)
    }
    static var heading1: UIFont {
        return .regularFont(size: 25)
    }
    static var body1: UIFont { //city list view
        return .regularFont(size: 20)
    }
    static var body2: UIFont { //city search
        return .lightFont(size: 20)
    }
    static var body3: UIFont { //city search
        return .regularFont(size: 18)
    }
    static var detailTitle: UIFont {
        return .lightFont(size: 16)
    }
    static var detailBody: UIFont {
        return .regularFont(size: 24)
    }

}
