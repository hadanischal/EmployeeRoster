//
//  MaterializedSequenceResult.swift
//  EmployeeRosterTests
//
//  Created by Nischal Hada on 7/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxBlocking
import XCTest

extension MaterializedSequenceResult {
    /// A convenience method for testing that a stream has ended with a failure
    /// - parameter error: The expected error that will be thrown by the stream
    /// Replaces the longer switch statement checking
    func assertSequenceDidFail<T: Error & Equatable>(withError expectedError: T) {
        switch self {
        case .completed:
            XCTFail("Assertion failed, stream completed succesfully")
        case .failed(_, let error):
            XCTAssertEqual(error as? T, expectedError)
        }
    }
    /// A convenience method for testing that a stream has ended with a failure
    /// Replaces the longer switch statement checking
    func assertSequenceDidFail() {
        switch self {
        case .completed:
            XCTFail("Assertion failed, stream completed succesfully")
        case .failed(_, let error):
            XCTAssertNotNil(error)
        }
    }
    /// A convenience method for testing that a stream has completed
    /// Replaces the longer switch statement checking
    func assertSequenceCompletes() {
        switch self {
        case .completed:
        break // pass the test
        case .failed(_, let error):
            XCTFail("error occured \(error)")
        }
    }
}
