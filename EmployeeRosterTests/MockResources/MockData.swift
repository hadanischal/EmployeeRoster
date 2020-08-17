//
//  MockData.swift
//  EmployeeRosterTests
//
//  Created by Nischal Hada on 7/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

@testable import EmployeeRoster
import Foundation
import XCTest

class MockData {
    func stubEmployeeModel() -> EmployeeModel? {
        guard let data = self.getData() else {
            XCTAssert(false, "Can't get data from jobs.json")
            return nil
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let result = try? decoder.decode(EmployeeModel.self, from: data) {
            return result
        } else {
            XCTAssert(false, "Unable to parse ArticlesList results")
            return nil
        }
    }

    func employeeList() -> [[EmployeeListDTO]] {
        guard
            let data = stubEmployeeModel(),
            let scheduledToday = data.scheduledToday,
            let roster = data.roster
            else { return [] }

        return [[EmployeeListDTO(scheduledToday)],
                roster.map { EmployeeListDTO($0) }]
    }

    func getData() -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "employee", withExtension: "json") else {
            XCTFail("Missing file: employee.json")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            XCTFail("unable to read json")
            return nil
        }
    }
}
