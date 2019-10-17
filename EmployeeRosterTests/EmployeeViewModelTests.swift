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
        var mockRealmManager: MockRealmManagerDataSource!
        var mockEventsCalendarManager: MockEventsCalendarManagerDataSource!

        var testScheduler: TestScheduler!
        let employeeModel: EmployeeModel = MockData().stubEmployeeModel() ?? EmployeeModel.empty

        describe("EmployeeViewModel") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockGetEmployeeInfo = MockGetEmployeeInfoHandlerProtocol()
                stub(mockGetEmployeeInfo, block: { stub in
                    when(stub.request()).thenReturn(Observable.just(EmployeeModel.empty))
                })

                mockRealmManager = MockRealmManagerDataSource()
                stub(mockRealmManager) { stub in
                    when(stub.fetchEmployeeInfo()).thenReturn(Single.just(employeeModel))
                    when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.empty())
                }

                mockEventsCalendarManager = MockEventsCalendarManagerDataSource()
                stub(mockEventsCalendarManager) { stub in
                    when(stub.addEventToCalendar(event: any())).thenReturn(Completable.empty())
                    when(stub.presentCalendarModalToAddEvent(event: any())).thenReturn(Completable.empty())
                }

                testViewModel = EmployeeViewModel(withGetWeather: mockGetEmployeeInfo, withRealmManager: mockRealmManager)
            }

            describe("Get Employee Info from server", {

                context("when server request succeed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.just(employeeModel))
                        })
                        stub(mockRealmManager) { stub in
                            when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.empty())
                        }
                        testScheduler.scheduleAt(300, action: {
                            testViewModel.getRosterInfo()
                        })
                    }
                    it("it completed successfully", closure: {
                        testScheduler.scheduleAt(300, action: {
                            verify(mockGetEmployeeInfo).request()
                        })
                    })
                    it("it save to local DB successfully", closure: {
                        testScheduler.scheduleAt(300, action: {
                            verify(mockRealmManager).saveEmployeeInfo(withInfo: any())
                        })
                    })

                    it("emits the employeeResult to the UI", closure: {
                        let res = testScheduler.start { testViewModel.employeeResult.asObservable() }
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.next(300, employeeModel)]
                        expect(res.events).to(equal(correctResult))
                    })
                })

                context("when server request failed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.error(RxError.noElements))
                        })
                        stub(mockRealmManager) { stub in
                            when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.empty())
                        }
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

            describe("Save and retreive Employee Info from Database", {

                context("when saveEmployeeInfo to realmManager succeed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.just(EmployeeModel.empty))
                        })
                        stub(mockRealmManager) { stub in
                            when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.empty())
                        }
                        testViewModel.getRosterInfo()
                    }
                    it("calls to realmManager to saveEmployeeInfo", closure: {
                        verify(mockRealmManager).saveEmployeeInfo(withInfo: any())
                    })
                })

                context("when saveEmployeeInfo to realmManager failed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.just(EmployeeModel.empty))
                        })
                        stub(mockRealmManager) { stub in
                            when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.error(MockError.noElements))
                        }
                        testViewModel.getRosterInfo()
                    }
                    it("calls to realmManager to saveEmployeeInfo", closure: {
                        verify(mockRealmManager).saveEmployeeInfo(withInfo: any())
                    })
                })

                context("when getRosterInfo from realmManager succeed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.just(employeeModel))
                        })
                        stub(mockRealmManager) { stub in
                            when(stub.fetchEmployeeInfo()).thenReturn(Single.just(employeeModel))
                        }
                        testScheduler.scheduleAt(300) {
                            testViewModel.getRosterInfoFromDB()
                        }
                    }
                    it("calls to realmManager to saveEmployeeInfo", closure: {
                        testScheduler.scheduleAt(300) {
                            verify(mockRealmManager).fetchEmployeeInfo()
                        }
                    })
                    it("emits the employeeResult to the UI", closure: {
                        let res = testScheduler.start { testViewModel.employeeResult.asObservable() }
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.next(300, employeeModel)]
                        expect(res.events).to(equal(correctResult))
                    })
                })
            })
        }
    }
}
