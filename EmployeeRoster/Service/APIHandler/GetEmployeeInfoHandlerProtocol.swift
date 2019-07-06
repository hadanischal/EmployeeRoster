//
//  GetEmployeeInfoHandlerProtocol.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxSwift

protocol GetEmployeeInfoHandlerProtocol {
    func request() -> Observable<EmployeeModel>
}
