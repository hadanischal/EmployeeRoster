//
//  RealmRoster.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 8/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RealmSwift

class RealmRoster: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var fromDate: String = ""
    @objc dynamic var toDate: String = ""

    func update(withRosterModel roster: RosterModel) {
        self.name = roster.name ?? ""
        self.fromDate = roster.fromDate ?? ""
        self.toDate = roster.toDate ?? ""
    }
}
