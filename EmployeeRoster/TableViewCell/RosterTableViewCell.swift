//
//  RosterTableViewCell.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

class RosterTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView?
    private let imageUrl = "https://picsum.photos/1920/1080?random"

    var dataValue: ScheduleModel? {
        didSet {
            guard let data = dataValue else {
                return
            }
            nameLabel?.text = data.name
            startDateLabel?.text = "Start Date: \(data.from_date ?? "")"
            endDateLabel?.text = "End date:\(data.to_date ?? "")"
            photoImageView?.imageFromUrl(urlString: imageUrl)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel?.textColor = UIColor.white
        startDateLabel?.textColor = UIColor.white
        endDateLabel?.textColor = UIColor.white
        self.photoImageView?.contentMode =   UIView.ContentMode.scaleAspectFill
    }
}
