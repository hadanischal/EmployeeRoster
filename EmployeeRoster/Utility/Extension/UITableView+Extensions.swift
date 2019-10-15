//
//  UITableView+Extensions.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 10/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
}

extension UITableView {
    func hideEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }

    func scrollToTopRow() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}
