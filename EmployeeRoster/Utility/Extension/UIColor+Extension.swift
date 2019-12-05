//
//  UIColor+Extension.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//
//swiftlint:disable all

import UIKit

extension UIColor {
    
    static var primaryLight: UIColor {
        return ColorName.cyan.color
    }
    
    static var darkText: UIColor {
        return ColorName.caparol.color
    }
    
    static var text: UIColor {
        return ColorName.darkCharcoal.color
    }
    
    static var lightText: UIColor {
        return ColorName.charcoal66.color
    }
    
    static var extraLightText: UIColor {
        return ColorName.charcoal99.color
    }
    
    static var buttonBackgroundColor: UIColor {
        return ColorName.caribbeanBlue.color
    }
    
    static var tableViewBackgroundColor: UIColor {
        return ColorName.shadeMagenta.color
    }
    
    static var contentViewBackgroundColor: UIColor {
        return ColorName.shadeMagenta.color
    }
    
    static var imageBackgroundColor: UIColor {
        return ColorName.coral.color
    }
}

extension UIColor {
    
    // MARK: - Computed Properties
    
    var toHex: String? {
        return toHex()
    }
    
    // MARK: - From UIColor to String
    
    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
}
