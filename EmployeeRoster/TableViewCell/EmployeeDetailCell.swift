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
    private let imageUrl = "https://i.pravatar.cc/300"

    var dataValue: RosterModel? {
        didSet {
            guard let data = dataValue else {
                return
            }
            nameLabel?.text = data.name
            startDateLabel?.text = "Start Date: \(data.from_date ?? "")"
            endDateLabel?.text = "End date:\(data.to_date ?? "")"
            profileImage?.imageFromUrl(urlString: imageUrl)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
