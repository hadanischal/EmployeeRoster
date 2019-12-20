//
//  EventsModel.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 12/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import EventStoreHelperRx

extension EventsModel {
     init?(withRosterModel rosterModel: RosterModel) {
        guard let name = rosterModel.name,
            let fromDate = rosterModel.fromDate?.yyyyMMddDate,
            let toDate = rosterModel.toDate?.yyyyMMddDate else {
                return nil
        }
        self.init(title: "\(name) on Roster",
            startDate: fromDate,
            endDate: toDate,
            location: nil,
            notes: nil,
            alarmMinutesBefore: 30)
    }
}

extension EventsModel {
    init?(withScheduleModel scheduleModel: ScheduleModel) {
        guard let name = scheduleModel.name,
            let fromDate = scheduleModel.fromDate?.yyyyMMddDate,
            let toDate = scheduleModel.toDate?.yyyyMMddDate else {
                return nil
        }
        self.init(title: "\(name) on Roster",
               startDate: fromDate,
               endDate: toDate,
               location: nil,
               notes: nil,
               alarmMinutesBefore: 30)
    }
}
