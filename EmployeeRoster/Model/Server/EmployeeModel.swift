//
//  EmployeeModel.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

struct EmployeeModel: Codable {
    let tenant: String?
    let motd: String?
    let scheduledToday: ScheduleModel?
    let roster: [RosterModel]?
}

extension EmployeeModel {
    init(withRealmEmployee realmEmployee: RealmEmployee) {
        self.tenant = realmEmployee.tenant
        self.motd = realmEmployee.motd
        self.scheduledToday = ScheduleModel(withRealmSchedule: realmEmployee.scheduledToday)
        let realmRoster = realmEmployee.roster
        self.roster = realmRoster.map { RosterModel(withRealmRoster: $0)}
    }
}

extension EmployeeModel {
    static var empty: EmployeeModel {
        return EmployeeModel(tenant: "", motd: "", scheduledToday: nil, roster: nil)
    }
}
