//
//  EmployeeListCell.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

class EmployeeListCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var detailLabel: UILabel?

    var dataValue: RosterModel? {
        didSet {
            guard let data = dataValue else {
                return
            }
            titleLabel?.text = data.name
            detailLabel?.text = data.from_date
        }
    }

}
