//
//  KeychainManagerTests.swift
//  EmployeeRosterTests
//
//  Created by Nischal Hada on 11/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Cuckoo
import KeychainAccess
import Nimble
import Quick
import RxSwift
import RxTest
import XCTest

@testable import EmployeeRoster

class KeychainHandlerTests: QuickSpec {
    override func spec() {
        let mockKey = "mock.nischal.keychain.key"

        describe("KeychainHandler") {
            var testModel: KeychainHandler!
            var testScheduler: TestScheduler!

            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                testModel = KeychainHandler(withKeyChainServiceKey: mockKey, andScheduler: MainScheduler.instance)
            }

            afterEach {
                let keychain = Keychain(service: mockKey)
                do {
                    try keychain.removeAll()
                } catch {
                    XCTAssert(false, "Unable to reset Keychain")
                }
            }

            describe("When user save in Keychain", {
                context("set String value in keychain", {
                    it("completes successfully", closure: {
                        let testObservable = testModel.set(value: "MockValue", key: "MockKey").asObservable()
                        let res = testScheduler.start { testObservable }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, "MockValue"),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })

                context("set data value in keychain", {
                    let data = Data()
                    it("completes successfully", closure: {
                        let testObservable = testModel.set(data: data, key: "MockDatakey").asObservable()
                        let res = testScheduler.start { testObservable }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, data),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })
            })

            describe("When user retrieve from Keychain", {
                context("retrieve String value from keychain", {
                    beforeEach {
                        _ = testModel.set(value: "MockValue", key: "MockKey").toBlocking().materialize()
                    }
                    it("completes successfully", closure: {
                        let testObservable = testModel.get(key: "MockKey").asObservable()
                        let res = testScheduler.start { testObservable }
                        expect(res.events.count).to(equal(2))
                        let value: String? = "MockValue"
                        let correctResult = [Recorded.next(200, value),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })

                context("retrieve data value from keychain", {
                    let data = Data()

                    beforeEach {
                        _ = testModel.set(data: data, key: "MockDatakey").toBlocking().materialize()
                    }
                    it("completes successfully", closure: {
                        let testObservable = testModel.getData(key: "MockDatakey").asObservable()
                        let res = testScheduler.start { testObservable }
                        expect(res.events.count).to(equal(2))
                        let value: Data? = data
                        let correctResult = [Recorded.next(200, value),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })
            })
        }
    }
}
