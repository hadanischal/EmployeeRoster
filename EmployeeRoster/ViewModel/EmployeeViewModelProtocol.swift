//
//  EmployeeViewModelProtocol.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxSwift

protocol EmployeeViewModelProtocol {
    var employeeResult: Observable<EmployeeModel> { get }
    var errorResult: Observable<Error> { get }
    func viewDidLoad()
    func addEventToCalendar(withRosterModel rosterModel: RosterModel) -> Observable<AddEventRoute>
}
