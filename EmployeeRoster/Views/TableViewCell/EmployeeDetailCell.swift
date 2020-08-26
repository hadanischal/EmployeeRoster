//
//  EmployeeDetailCell.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 26/8/20.
//  Copyright © 2020 NischalHada. All rights reserved.
//

import UIKit

class EmployeeDetailCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel?.font = .body1
        startDateLabel?.font = .body2
        endDateLabel?.font = .body2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(_ data: EmployeeListDTO) {
        nameLabel?.text = data.name
        startDateLabel?.text = "Start Date: \(data.fromDate)"
        endDateLabel?.text = "End date:\(data.toDate)"
        profileImage?.setImage(withName: data.name)
    }
}
