//
//  EmployeeViewModelTests.swift
//  EmployeeRosterTests
//
//  Created by Nischal Hada on 7/9/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Cuckoo
import RxTest
import RxBlocking
import RxSwift
@testable import EmployeeRoster

class EmployeeViewModelTests: QuickSpec {

    override func spec() {
        var testViewModel: EmployeeViewModel!
        var mockGetEmployeeInfo: MockGetEmployeeInfoHandlerProtocol!
        var testScheduler: TestScheduler!

        describe("EmployeeViewModel") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockGetEmployeeInfo = MockGetEmployeeInfoHandlerProtocol()
                stub(mockGetEmployeeInfo, block: { stub in
                    when(stub.request()).thenReturn(Observable.just(EmployeeModel.empty))
                })
                testViewModel = EmployeeViewModel(withGetWeather: mockGetEmployeeInfo)
            }

            describe("Get Employee Info from server", {

                context("when server request succeed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.just(EmployeeModel.empty))
                        })
                        testViewModel.getRosterInfo()
                    }
                    it("it completed successfully", closure: {
                        verify(mockGetEmployeeInfo).request()
                    })
                })

                it("emits the employeeResult to the UI", closure: {
                    testScheduler.scheduleAt(300, action: {
                        testViewModel.getRosterInfo()
                    })
                    let res = testScheduler.start { testViewModel.employeeResult.asObservable() }
                    expect(res.events.count).to(equal(1))
                    expect(res.events.first?.time).to(equal(300))
                    expect(res.events.last?.time).to(equal(300))
                })

                context("when server request failed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.error(RxError.noElements))
                        })
                        testViewModel.getRosterInfo()
                    }

                    it("doesnt emits employeeResult to the UI", closure: {
                        testScheduler.scheduleAt(300, action: {
                            testViewModel.getRosterInfo()
                        })
                        let res = testScheduler.start { testViewModel.employeeResult.asObservable() }
                        expect(res.events).to(beEmpty())
                    })
                })
            })
        }
    }
}
