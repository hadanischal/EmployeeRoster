//
//  EmployeeListModelTests.swift
//  EmployeeRosterTests
//
//  Created by Nischal Hada on 28/12/19.
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

final class EmployeeListModelTests: QuickSpec {

    override func spec() {
        var testViewModel: EmployeeListModel!
        var mockGetEmployeeInfo: MockGetEmployeeInfoHandlerProtocol!
        var mockRealmManager: MockRealmManagerDataSource!

        var testScheduler: TestScheduler!
        let employeeModel: EmployeeModel = MockData().stubEmployeeModel() ?? EmployeeModel.empty

        describe("EmployeeListModel") {
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

                testViewModel = EmployeeListModel(withGetWeather: mockGetEmployeeInfo, withRealmManager: mockRealmManager)
            }

            describe("Get Employee Info from server", {

                context("when server request succeed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.just(employeeModel))
                        })
                        stub(mockRealmManager) { stub in
                            when(stub.fetchEmployeeInfo()).thenReturn(Single.error(MockError.noElements))
                            when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.empty())
                        }
                        _ = try? testViewModel.getRosterInfo().toBlocking(timeout: 2).toArray()

                    }
                    it("it completed successfully", closure: {
                        verify(mockGetEmployeeInfo).request()
                    })
                    it("it save to local DB successfully", closure: {
                        verify(mockRealmManager).saveEmployeeInfo(withInfo: any())
                    })

                    it("emits the employeeResult to the UI", closure: {
                        let res = testScheduler.start { testViewModel.getRosterInfo().asObservable() }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, employeeModel),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })

                context("when server request failed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.error(RxError.noElements))
                        })
                        stub(mockRealmManager) { stub in
                            when(stub.fetchEmployeeInfo()).thenReturn(Single.error(MockError.noElements))
                            when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.empty())
                        }
                    }

                    it("doesnt emits employeeResult to the UI", closure: {
                        let res = testScheduler.start { testViewModel.getRosterInfo().asObservable() }
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.completed(200, EmployeeModel.self)]
                        expect(res.events).to(equal(correctResult))
                    })
                })
            })

            describe("Save and retreive Employee Info from Database", {

                context("when saveEmployeeInfo to realmManager succeed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.just(employeeModel))
                        })
                        stub(mockRealmManager) { stub in
                            when(stub.fetchEmployeeInfo()).thenReturn(Single.error(MockError.noElements))
                            when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.empty())
                        }
                        _ = try? testViewModel.getRosterInfo().toBlocking(timeout: 2).toArray()
                    }
                    it("calls to realmManager to saveEmployeeInfo", closure: {
                        verify(mockRealmManager).saveEmployeeInfo(withInfo: any())
                    })
                    it("emits the employeeResult to the UI", closure: {
                        let res = testScheduler.start { testViewModel.getRosterInfo().asObservable() }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, employeeModel),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })

                context("when saveEmployeeInfo to realmManager failed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.just(employeeModel))
                        })
                        stub(mockRealmManager) { stub in
                            when(stub.fetchEmployeeInfo()).thenReturn(Single.error(MockError.noElements))
                            when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.error(MockError.noElements))
                        }
                        _ = try? testViewModel.getRosterInfo().toBlocking(timeout: 2).toArray()

                    }
                    it("calls to realmManager to saveEmployeeInfo", closure: {
                        verify(mockRealmManager).saveEmployeeInfo(withInfo: any())
                    })
                    it("emits the employeeResult to the UI", closure: {
                        let res = testScheduler.start { testViewModel.getRosterInfo().asObservable() }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, employeeModel),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })

                context("when getRosterInfo from realmManager succeed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.error(MockError.noElements))
                        })
                        stub(mockRealmManager) { stub in
                            when(stub.fetchEmployeeInfo()).thenReturn(Single.just(employeeModel))
                            when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.error(MockError.noElements))
                        }
                        _ = try? testViewModel.getRosterInfo().toBlocking(timeout: 2).toArray()
                    }
                    it("calls to realmManager to saveEmployeeInfo", closure: {
                        verify(mockRealmManager).fetchEmployeeInfo()
                    })
                    it("emits the employeeResult to the UI", closure: {
                        let res = testScheduler.start { testViewModel.getRosterInfo().asObservable() }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, employeeModel),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })
            })
        }
    }
}
