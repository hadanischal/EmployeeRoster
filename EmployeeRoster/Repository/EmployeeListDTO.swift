//
//  EmployeeListDTO.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 15/8/20.
//  Copyright © 2020 NischalHada. All rights reserved.
//

import Foundation

struct EmployeeListDTO: Equatable {
    let name: String
    let fromDate: String
    let toDate: String
}

extension EmployeeListDTO {
    init(_ data: RosterModel) {
        self.name = data.name ?? ""
        self.fromDate = data.fromDate ?? ""
        self.toDate = data.toDate ?? ""
    }
}

extension EmployeeListDTO {
    init(_ data: ScheduleModel) {
        self.name = data.name ?? ""
        self.fromDate = data.fromDate ?? ""
        self.toDate = data.toDate ?? ""
    }
}
