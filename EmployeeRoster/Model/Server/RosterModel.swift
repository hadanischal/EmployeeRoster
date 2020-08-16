//
//  RosterModel.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

struct RosterModel: Codable, Equatable {
    let name: String?
    let fromDate: String?
    let toDate: String?
}

extension RosterModel {
    init(withRealmRoster realmRoster: RealmRoster) {
        self.name = realmRoster.name
        self.fromDate = realmRoster.fromDate
        self.toDate = realmRoster.toDate
    }
}
