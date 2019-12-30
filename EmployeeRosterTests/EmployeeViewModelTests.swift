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
        var mockEmployeeListModel: MockEmployeeListModelDataSource!
        var mockEventsCalendarManager: MockEventsCalendarManagerDataSource!

        var testScheduler: TestScheduler!
        let employeeModel: EmployeeModel = MockData().stubEmployeeModel() ?? EmployeeModel.empty

        describe("EmployeeViewModel") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockEmployeeListModel = MockEmployeeListModelDataSource()
                stub(mockEmployeeListModel, block: { stub in
                    when(stub.getRosterInfo()).thenReturn(Observable.just(EmployeeModel.empty))
                })

                mockEventsCalendarManager = MockEventsCalendarManagerDataSource()
                stub(mockEventsCalendarManager) { stub in
                    when(stub.addEventToCalendar(event: any())).thenReturn(Completable.empty())
                    when(stub.presentCalendarModalToAddEvent(event: any())).thenReturn(Completable.empty())
                }

                testViewModel = EmployeeViewModel(withEmployeeListModel: mockEmployeeListModel, withEventsCalendarManager: mockEventsCalendarManager)
            }

            describe("Get Employee Info from EmployeeListModelDataSource", {

                context("when get request succeed ", {
                    beforeEach {
                        stub(mockEmployeeListModel, block: { stub in
                            when(stub.getRosterInfo()).thenReturn(Observable.just(employeeModel))
                        })

                        testScheduler.scheduleAt(300, action: {
                            testViewModel.viewDidLoad()
                        })
                    }
                    it("it call EmployeeListModelDataSource for employee info", closure: {
                        testScheduler.scheduleAt(300, action: {
                            verify(mockEmployeeListModel).getRosterInfo()
                        })
                    })
                    it("emits the employeeResult to the UI", closure: {
                        let res = testScheduler.start { testViewModel.employeeResult.asObservable() }
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.next(300, employeeModel)]
                        expect(res.events).to(equal(correctResult))
                    })
                })

                context("when get request failed ", {
                    beforeEach {
                        stub(mockEmployeeListModel, block: { stub in
                            when(stub.getRosterInfo()).thenReturn(Observable.error(RxError.noElements))
                        })
                        testScheduler.scheduleAt(300, action: {
                            testViewModel.viewDidLoad()
                        })
                    }
                    it("it call EmployeeListModelDataSource for employee info", closure: {
                        testScheduler.scheduleAt(300, action: {
                            verify(mockEmployeeListModel).getRosterInfo()
                        })
                    })

                    it("doesnt emits employeeResult to the UI", closure: {
                        let res = testScheduler.start { testViewModel.employeeResult.asObservable() }
                        expect(res.events).to(beEmpty())
                    })
                })
            })
        }
    }
}
