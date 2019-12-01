//
//  EmployeeDetailCell.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

class EmployeeDetailCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel?.font = .body1
        startDateLabel?.font = .body2
        endDateLabel?.font = .body2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(_ rosterModel: RosterModel?) {
        guard let data = rosterModel else { return }
        nameLabel?.text = data.name
        startDateLabel?.text = "Start Date: \(data.fromDate ?? "")"
        endDateLabel?.text = "End date:\(data.toDate ?? "")"
        profileImage?.setImage(withName: data.name ?? "")
    }
}
