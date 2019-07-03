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
    let scheduled_today: ScheduleModel?
    let roster:[RosterModel]?
}

extension EmployeeModel {
    static var empty: EmployeeModel {
        return EmployeeModel(tenant: "", motd: "", scheduled_today: nil, roster: nil)
    }
}
