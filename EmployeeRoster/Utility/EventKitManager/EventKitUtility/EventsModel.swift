//
//  EventsModel.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 12/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

struct EventsModel {
    let title: String
    let startDate: Date
    let endDate: Date
    let location: String?
    let notes: String?
    let alarmMinutesBefore: Int
}
