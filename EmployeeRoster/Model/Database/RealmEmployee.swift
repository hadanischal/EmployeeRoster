//
//  RealmEmployee.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 8/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RealmSwift

class RealmEmployee: Object {
    @objc dynamic var tenant: String = ""
    @objc dynamic var motd: String = ""
    @objc dynamic var scheduledToday: RealmSchedule?
    let roster = List<RealmRoster>()

    func update(withEmployeeModel employee: EmployeeModel) {
        self.tenant = employee.tenant ?? ""
        self.motd = employee.motd ?? ""
    }
}
