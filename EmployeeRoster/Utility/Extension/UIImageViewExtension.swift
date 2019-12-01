//
//  UIImageViewExtension.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

private let disposeBag = DisposeBag()

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        requestData(.get, urlString)
        .observeOn(MainScheduler.instance)
            .subscribe(onNext: { response in
                self.image = UIImage(data: response.1)
            }).disposed(by: disposeBag)

    }
}

extension UIImageView {
     func setImage(withName name: String) {
        self.image = self.image(WithName: name)
      }

    func image(WithName name: String) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
//        nameLabel.backgroundColor = .imageBackgroundColor
        nameLabel.textColor = .white
//        nameLabel.font = .imageTitle
        nameLabel.text = String(name.prefix(2)).uppercased()
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
}
