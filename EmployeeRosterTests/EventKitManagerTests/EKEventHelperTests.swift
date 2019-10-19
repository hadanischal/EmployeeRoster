//
//  EKEventHelperTests.swift
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

class EKEventHelperTests: QuickSpec {

    override func spec() {
        var testRequest: EKEventHelper!
        var testScheduler: TestScheduler!
        var mockEKEventStore: MockEKEventStore!

        describe("EKEventHelper") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)

                mockEKEventStore = MockEKEventStore()
                stub(mockEKEventStore) { (stub) in
                    when(stub).requestAccess(to: any(), completion: any()).thenDoNothing()
                }
                testRequest = EKEventHelper(withEKEventStore: mockEKEventStore)
            }

            describe("Get authorizationStatus Info from EKEventStore", {

                context("when authorizationStatus request succeed ", {
                    var result: MaterializedSequenceResult<EKEventHelperStatus>?
                    beforeEach {
                        result = testRequest.authorizationStatus.toBlocking().materialize()
                    }
                    it("it completed successfully", closure: {
                        result?.assertSequenceCompletes()
                    })

                    it("emits EKEventHelperStatus notDetermined to the UI", closure: {
                        let res = testScheduler.start { testRequest.authorizationStatus.asObservable() }
                        expect(res.events.count).to(equal(2))
                    })
                })
            })

            describe("When call EKEventStore for requestAccess") {
                context("when requestAccess request succeed with authorizationStatus true", {
                    var result: MaterializedSequenceResult<Bool>?

                    beforeEach {
                        stub(mockEKEventStore) { (stub) in
                            when(stub).requestAccess(to: any(), completion: any()).then { (arg0) in
                                let (_, eventStoreRequestAccessCompletionHandler) = arg0
                                eventStoreRequestAccessCompletionHandler(true, nil)
                            }
                        }
                        result = testRequest.requestAccess.toBlocking().materialize()
                    }
                    it("completes successfully", closure: {
                        result?.assertSequenceCompletes()
                    })
                    it("calls to the EKEventStore for requestAccess", closure: {
                        verify(mockEKEventStore).requestAccess(to: any(), completion: any())
                    })
                    it("emits the authorizationStatus true", closure: {
                        let res = testScheduler.start { testRequest.requestAccess.asObservable() }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, true),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })

                })

                context("when requestAccess request succeed with authorizationStatus false", {
                    var result: MaterializedSequenceResult<Bool>?

                    beforeEach {
                        stub(mockEKEventStore) { (stub) in
                            when(stub).requestAccess(to: any(), completion: any()).then { (arg0) in
                                let (_, eventStoreRequestAccessCompletionHandler) = arg0
                                eventStoreRequestAccessCompletionHandler(false, nil)
                            }
                        }
                        result = testRequest.requestAccess.toBlocking().materialize()
                    }
                    it("completes successfully", closure: {
                        result?.assertSequenceCompletes()
                    })
                    it("calls to the EKEventStore for requestAccess", closure: {
                        verify(mockEKEventStore).requestAccess(to: any(), completion: any())
                    })
                    it("emits the authorizationStatus false", closure: {
                        let res = testScheduler.start { testRequest.requestAccess.asObservable() }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, false),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                    it("calls to the EKEventStore for requestAccess", closure: {
                        verify(mockEKEventStore).requestAccess(to: any(), completion: any())
                    })
                })

                context("when requestAccess failed with error ", {
                    var result: MaterializedSequenceResult<Bool>?

                    beforeEach {
                        stub(mockEKEventStore) { (stub) in
                            when(stub).requestAccess(to: any(), completion: any()).then { (arg0) in
                                let (_, eventStoreRequestAccessCompletionHandler) = arg0
                                eventStoreRequestAccessCompletionHandler(false, MockError.noElements)
                            }
                        }
                        result = testRequest.requestAccess.toBlocking().materialize()
                    }
                    it("it fails with error", closure: {
                        result?.assertSequenceDidFail()
                    })
                    it("calls to the EKEventStore for requestAccess", closure: {
                        verify(mockEKEventStore).requestAccess(to: any(), completion: any())
                    })
                    it("emits the authorizationStatus true", closure: {
                        let res = testScheduler.start { testRequest.requestAccess.asObservable() }
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.error(200, MockError.noElements, Bool.self)]
                        expect(res.events).to(equal(correctResult))
                    })
                })
            }
        }
    }
}
