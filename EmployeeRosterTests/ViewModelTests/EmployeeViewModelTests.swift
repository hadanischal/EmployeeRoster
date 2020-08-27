//
//  EmployeeViewModelTests.swift
//  EmployeeRosterTests
//
//  Created by Nischal Hada on 7/9/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//
// swiftlint:disable force_cast

import Cuckoo
@testable import EmployeeRoster
import Nimble
import Quick
import RxBlocking
import RxSwift
import RxTest
import XCTest

class EmployeeViewModelTests: QuickSpec {
    override func spec() {
        var testViewModel: EmployeeListViewModel!
        var mockRepository: MockEmployeeListRepositoryHandling!

        var testScheduler: TestScheduler!
        let employeeList = MockData().employeeList()

        describe("EmployeeViewModel") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockRepository = MockEmployeeListRepositoryHandling()
                stub(mockRepository, block: { stub in
                    when(stub.getRosterInfo()).thenReturn(Observable.empty())
                })

                testViewModel = EmployeeListViewModel(withRepositoryHandling: mockRepository)
            }

            describe("Get Employee Info from EmployeeListModelDataSource", {
                context("when get request succeed ", {
                    beforeEach {
                        stub(mockRepository, block: { stub in
                            when(stub.getRosterInfo()).thenReturn(Observable.just(employeeList))
                        })

                        testScheduler.scheduleAt(300) {
                            testViewModel.viewDidLoad()
                        }
                        testViewModel.viewDidLoad()
                    }
                    it("it call EmployeeListModelDataSource for employee info", closure: {
                        verify(mockRepository).getRosterInfo()
                    })

                    it("emits the updateInfo to the UI") {
                        let observable = testViewModel.updateInfo.asObservable()
                        let res = testScheduler.start { observable }
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.next(300, true)]
                        expect(res.events).to(equal(correctResult))
                    }

                    it("wont emits the errorResult to the UI") {
                        let res = testScheduler.start { testViewModel.errorResult }
                        expect(res.events).toNot(beNil())
                        expect(res.events.count).to(equal(0))
                    }

                    it("emits the isLoading to the UI") {
                        let res = testScheduler.start { testViewModel.isLoading }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, false), Recorded.next(300, false)]
                        expect(res.events).to(equal(correctResult))
                    }

                    it("it sets employeeList correctly") {
                        expect(testViewModel.employeeList).to(equal(employeeList))
                    }
                })

                context("when get request failed ", {
                    beforeEach {
                        stub(mockRepository, block: { stub in
                            when(stub.getRosterInfo()).thenReturn(Observable.error(mockError))
                        })
                        testScheduler.scheduleAt(300) {
                            testViewModel.viewDidLoad()
                        }
                        testViewModel.viewDidLoad()
                    }
                    it("it call EmployeeListModelDataSource for employee info", closure: {
                        verify(mockRepository).getRosterInfo()
                    })

                    it("doesnt emits updateInfo to the UI") {
                        let observable = testViewModel.updateInfo.asObservable()
                        let res = testScheduler.start { observable }
                        expect(res.events).toNot(beNil())
                        expect(res.events.count).to(equal(0))
                    }
                    it("emits the errorResult to the UI") {
                        let res = testScheduler.start { testViewModel.errorResult.map { $0 as! MockError } }
                        expect(res.events).toNot(beNil())
                        expect(res.events.count).to(equal(1))

                        let correctResult = [Recorded.next(300, mockError)]
                        expect(res.events).to(equal(correctResult))
                    }

                    it("emits the isLoading to the UI") {
                        let res = testScheduler.start { testViewModel.isLoading }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, false), Recorded.next(300, false)]
                        expect(res.events).to(equal(correctResult))
                    }

                    it("it sets employeeList correctly") {
                        expect(testViewModel.employeeList).to(equal([]))
                    }
                })
            })
        }
    }
}
