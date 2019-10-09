//
//  ScheduleModel.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

struct ScheduleModel: Codable {
    let name: String?
    let fromDate: String?
    let toDate: String?
}

extension ScheduleModel {
    init?(withRealmSchedule realmSchedule: RealmSchedule?) {
        guard let realmSchedule = realmSchedule else { return nil }
        self.name = realmSchedule.name
        self.fromDate = realmSchedule.fromDate
        self.toDate = realmSchedule.toDate
    }
}
