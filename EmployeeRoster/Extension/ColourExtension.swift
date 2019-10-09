//
//  ColourExtension.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 18/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

// swiftlint:disable all
extension UIColor {
    static var primary: UIColor {
//        return UIColor(rgb: 0x40c5eeff)
        return UIColor(hex: "#40c5eeff") ?? UIColor.gray //UIColor(hex: "#40C5EE")!
    }
    static var viewBackgroundColor: UIColor {
        return UIColor(red: 0.933, green: 0.941, blue: 0.945, alpha: 1.00)
    }
//    static var viewBackgroundColor: UIColor {
//        return UIColor(rgb: 0x5c9ac1)
//    }
    static var addCityViewBackgroundColor: UIColor {
        return UIColor(rgb: 0xEAE8EA)
    }
    static var barTintColor: UIColor {
        return UIColor(rgb: 0x5c9ac1)
    }
    
    static var titleTintColor: UIColor {
        return UIColor.white
    }
}

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}
