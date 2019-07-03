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
