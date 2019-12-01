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

    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel?.textColor = UIColor.white
        startDateLabel?.textColor = UIColor.white
        endDateLabel?.textColor = UIColor.white

        nameLabel?.font = .heading1
        startDateLabel?.font = .body1
        endDateLabel?.font = .body2
        self.photoImageView?.contentMode =   UIView.ContentMode.scaleAspectFill
    }

    func configure(_ scheduleValue: ScheduleModel?) {
        guard let data = scheduleValue else { return }
        nameLabel?.text = data.name
        startDateLabel?.text = "Start Date: \(data.fromDate ?? "")"
        endDateLabel?.text = "End date:\(data.toDate ?? "")"
        photoImageView?.imageFromUrl(urlString: imageUrl)
    }
}
