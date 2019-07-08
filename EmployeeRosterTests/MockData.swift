//
//  MockData.swift
//  EmployeeRosterTests
//
//  Created by Nischal Hada on 7/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import XCTest
@testable import EmployeeRoster

class MockData {
    func getData() -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "employee", withExtension: "json") else {
            XCTFail("Missing file: employee.json")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch (_) {
            XCTFail("unable to read json")
            return nil
        }
    }
}
