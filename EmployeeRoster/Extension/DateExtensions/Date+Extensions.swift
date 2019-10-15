//
//  Date+Extensions.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 13/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

extension Date {
    var ddMMyyyyString: String {
        return DateFormatter.ddMMyyyy.string(from: self)
    }

    var ddMMyyString: String {
        return DateFormatter.ddMMyy.string(from: self)
    }

    var  MMyyyyString: String {
        return DateFormatter.MMyyyy.string(from: self)
    }
}
