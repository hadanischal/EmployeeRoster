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

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.font = .body1
        detailLabel?.font = .body2
    }

    func configure(_ rosterModel: RosterModel?) {
        guard let data = rosterModel else { return }
        titleLabel?.text = data.name
        detailLabel?.text = data.fromDate
    }
}
