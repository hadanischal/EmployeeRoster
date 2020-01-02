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
import EventStoreHelperRx
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
                    when(stub.addEventToCalendar(event: any())).thenReturn(Single.just(EventsCalendarStatus.denied))
                    when(stub.presentCalendarModalToAddEvent(event: any())).thenReturn(Single.just(EventsCalendarStatus.denied))
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

            describe("Add event to Calendar") {
                var roster: RosterModel!
                beforeEach {
                    guard let rosterModel = employeeModel.roster?.first else { fail("employee roster mustnot be nil"); return}
                    roster = rosterModel
                }

                context("When EventsCalendarStatus is denied") {
                    var addEventResult: [AddEventRoute]?
                    beforeEach {
                        stub(mockEventsCalendarManager) { stub in
                            when(stub.addEventToCalendar(event: any())).thenReturn(Single.just(EventsCalendarStatus.denied))
                            when(stub.presentCalendarModalToAddEvent(event: any())).thenReturn(Single.just(EventsCalendarStatus.denied))
                        }
                        addEventResult = try? testViewModel.addEventToCalendar(withRosterModel: roster).toBlocking(timeout: 2).toArray()
                    }

                    it("call MockEventsCalendarManager to add event") {
                        verify(mockEventsCalendarManager).addEventToCalendar(event: any())
                    }

                    it("addEventToCalendar event count is 1", closure: {
                        expect(addEventResult?.count).to(equal(1))
                    })
                    it("emits AddEventRoute openSettings to the UI", closure: {
                        guard let result = addEventResult?.first else { fail("addEventResult is nil"); return}
                        guard case let AddEventRoute.openSettings(title, message) = result else { fail("AddEventRoute.openSettings not found:\(result)"); return}

                        expect(title).to(equal("This feature requires calender access"))
                        expect(message).to(equal("In iPhone settings, tap EmployeeRoster and turn on calender access"))
                    })
                }

                context("When EventsCalendarStatus is added") {
                    var addEventResult: [AddEventRoute]?
                    beforeEach {
                        stub(mockEventsCalendarManager) { stub in
                            when(stub.addEventToCalendar(event: any())).thenReturn(Single.just(EventsCalendarStatus.added))
                            when(stub.presentCalendarModalToAddEvent(event: any())).thenReturn(Single.just(EventsCalendarStatus.added))
                        }
                        addEventResult = try? testViewModel.addEventToCalendar(withRosterModel: roster).toBlocking(timeout: 2).toArray()
                    }

                    it("call MockEventsCalendarManager to add event") {
                        verify(mockEventsCalendarManager).addEventToCalendar(event: any())
                    }

                    it("addEventToCalendar event count is 1", closure: {
                        expect(addEventResult?.count).to(equal(1))
                    })
                    it("emits AddEventRoute eventAdded to the UI", closure: {
                        guard let result = addEventResult?.first else { fail("addEventResult is nil"); return}
                        guard case let AddEventRoute.eventAdded(title, message) = result else { fail("AddEventRoute.eventAdded not found:\(result)"); return}

                        expect(title).to(equal("Event added to Calendar"))
                        expect(message).to(equal("Event added to Calendar completed"))
                    })
                }

                context("When EventsCalendarStatus is error") {
                    var addEventResult: [AddEventRoute]?
                    beforeEach {
                        stub(mockEventsCalendarManager) { stub in
                            when(stub.addEventToCalendar(event: any())).thenReturn(Single.just(EventsCalendarStatus.error(.eventAlreadyExistsInCalendar)))
                            when(stub.presentCalendarModalToAddEvent(event: any())).thenReturn(Single.just(EventsCalendarStatus.error(.eventAlreadyExistsInCalendar)))
                        }
                        addEventResult = try? testViewModel.addEventToCalendar(withRosterModel: roster).toBlocking(timeout: 2).toArray()
                    }

                    it("call MockEventsCalendarManager to add event") {
                        verify(mockEventsCalendarManager).addEventToCalendar(event: any())
                    }

                    it("addEventToCalendar event count is 1", closure: {
                        expect(addEventResult?.count).to(equal(1))
                    })
                    it("emits AddEventRoute error to the UI", closure: {
                        guard let result = addEventResult?.first else { fail("addEventResult is nil"); return}
                        guard case let AddEventRoute.errorResult(error) = result else { fail("AddEventRoute.error not found:\(result)"); return}

                        expect(error.localizedDescription).to(equal("Unable to add event to Calendar"))
                        expect((error as? EKEventError)?.recoverySuggestion).to(equal("Event already exists in Calendar, Please create new event"))
                    })
                }
            }
        }
    }
}
