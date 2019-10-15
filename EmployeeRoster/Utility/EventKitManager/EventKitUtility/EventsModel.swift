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

extension EventsModel {
    init?(withRosterModel rosterModel: RosterModel) {
        guard let name = rosterModel.name,
            let fromDate = rosterModel.fromDate?.yyyyMMddDate,
            let toDate = rosterModel.toDate?.yyyyMMddDate else {
                return nil
        }
        self.title = "\(name) on Roster"
        self.startDate = fromDate
        self.endDate = toDate
        self.location = nil
        self.notes = nil
        self.alarmMinutesBefore = 30
    }
}

extension EventsModel {
    init?(withScheduleModel scheduleModel: ScheduleModel) {
        guard let name = scheduleModel.name,
            let fromDate = scheduleModel.fromDate?.yyyyMMddDate,
            let toDate = scheduleModel.toDate?.yyyyMMddDate else {
                return nil
        }

        self.title = "\(name) on Roster"
        self.startDate = fromDate
        self.endDate = toDate
        self.location = nil
        self.notes = nil
        self.alarmMinutesBefore = 30
    }
}
