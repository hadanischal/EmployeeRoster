//
//  RealmSchedule.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 8/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RealmSwift

class RealmSchedule: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var fromDate: String = ""
    @objc dynamic var toDate: String = ""

    func update(withScheduleModel schedule: ScheduleModel) {
        self.name = schedule.name ?? ""
        self.fromDate = schedule.fromDate ?? ""
        self.toDate = schedule.toDate ?? ""
    }
}
