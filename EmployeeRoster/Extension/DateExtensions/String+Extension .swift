//
//  String+Extension .swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 13/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

extension String {
    var yyyyMMddDate: Date? {
        return DateFormatter.yyyyMMdd.date(from: self)
    }
}
