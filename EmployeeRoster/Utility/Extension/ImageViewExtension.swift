//
//  ImageViewExtension.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 27/9/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(url: URL?) {
        self.kf.setImage(with: url, placeholder: Asset.Icons.placeholder.image)
    }
}

extension UIImageView {
    func setImage(withName name: String) {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .imageBackgroundColor
        nameLabel.textColor = .white
        nameLabel.font = .imageTitle
        nameLabel.text = String(name.prefix(2)).uppercased()
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            self.image = nameImage
        } else {
            self.image = Asset.Icons.placeholder.image
        }
    }
}
