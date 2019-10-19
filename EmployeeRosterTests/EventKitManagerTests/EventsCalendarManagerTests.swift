//
//  EventsCalendarManagerTests.swift
//  EmployeeRosterTests
//
//  Created by Nischal Hada on 15/10/19.
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

class EventsCalendarManagerTests: QuickSpec {

    override func spec() {
        var testRequest: EventsCalendarManager!
        var mockEKEventHelper: MockEKEventHelperDataSource!
        var mockEKEventStore: MockEKEventStore!
        let employeeModel: EmployeeModel = MockData().stubEmployeeModel() ?? EmployeeModel.empty

        describe("EventsCalendarManager") {
            beforeEach {
                mockEKEventHelper = MockEKEventHelperDataSource()
                stub(mockEKEventHelper, block: { stub in
                    when(stub.authorizationStatus).get.thenReturn(Single.just(.authorized))
                    when(stub.requestAccess).get.thenReturn(Single.just(true))
                })

                mockEKEventStore = MockEKEventStore()
                stub(mockEKEventStore) { (stub) in
                    when(stub).requestAccess(to: any(), completion: any()).thenDoNothing()
                }

                testRequest = EventsCalendarManager(withEKEventHelper: mockEKEventHelper, withEventStore: mockEKEventStore)
            }

            describe("When add Event To Calendar", {

                context("when authorizationStatus is denied", {
                    var result: MaterializedSequenceResult<Never>?
                    beforeEach {
                        stub(mockEKEventHelper, block: { stub in
                            when(stub.authorizationStatus).get.thenReturn(Single.just(.denied))
                        })

                        stub(mockEKEventStore) { (stub) in
                            when(stub).requestAccess(to: any(), completion: any()).thenDoNothing()
                            when(stub).predicateForEvents(withStart: any(), end: any(), calendars: any()).thenReturn(NSPredicate())
                            when(stub).events(matching: any()).thenReturn([])
                            when(stub).save(any(), span: any()).thenDoNothing()
                        }

                        guard let scheduledToday = employeeModel.scheduledToday,
                            let eventsModel = EventsModel(withScheduleModel: scheduledToday)  else {
                                fail("EventsModel not found")
                                return
                        }
                        result = testRequest.addEventToCalendar(event: eventsModel).toBlocking(timeout: 3).materialize()
                    }
                    it("it failed with error calendarAccessDeniedOrRestricted", closure: {
                        result?.assertSequenceDidFail(withError: EKEventError.calendarAccessDeniedOrRestricted)
                    })
                    it("calls to the mockEKEventHelper for authorizationStatus", closure: {
                        verify(mockEKEventHelper).authorizationStatus.get()
                    })
                })
            })
        }
    }
}
