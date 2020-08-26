//
//  NibLoadableView.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 26/8/20.
//  Copyright © 2020 NischalHada. All rights reserved.
//

import UIKit

protocol NibLoadableView: AnyObject {}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableViewCell: NibLoadableView {}
extension UICollectionViewCell: NibLoadableView {}
