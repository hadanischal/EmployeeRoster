//
//  DateFormatter+Formatters.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 13/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

extension DateFormatter {
    public static var ddMMyyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_AU")
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter
    }()

    public static var ddMMyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_AU")
        formatter.dateFormat = "dd / MM / yy"
        return formatter
    }()

    public static var MMyyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_AU")
        formatter.dateFormat = "MM / yyyy"
        return formatter
    }()

    public static var yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
