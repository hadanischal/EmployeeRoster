//
//  EmployeeNetworkHandlerTests.swift
//  EmployeeRosterTests
//
//  Created by Nischal Hada on 7/7/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Cuckoo
import Nimble
import Quick
import RxBlocking
import RxSwift
import RxTest
import XCTest

@testable import EmployeeRoster

class EmployeeNetworkHandlerTests: QuickSpec {
    override func spec() {
        var testRequest: EmployeeNetworkHandler!
        var mockWebService: MockWebServiceProtocol!

        describe("EmployeeNetworkHandler") {
            beforeEach {
                mockWebService = MockWebServiceProtocol()
                stub(mockWebService, block: { stub in
                    when(stub.request(with: any())).thenReturn(Observable.just(Data()))
                })
                testRequest = EmployeeNetworkHandler(withWebService: mockWebService)
            }

            describe("Get Employee Info from server", {
                context("when server request succeed ", {
                    var result: MaterializedSequenceResult<EmployeeModel>?
                    beforeEach {
                        stub(mockWebService, block: { stub in
                            when(stub.request(with: any())).thenReturn(Observable.just(mockData!))
                        })
                        result = testRequest.request().toBlocking().materialize()
                    }
                    it("it completed successfully", closure: {
                        result?.assertSequenceCompletes()
                    })
                })

                context("when server request failed ", {
                    var result: MaterializedSequenceResult<EmployeeModel>?
                    beforeEach {
                        stub(mockWebService, block: { stub in
                            when(stub.request(with: any())).thenReturn(Observable.error(RxError.noElements))
                        })
                        result = testRequest.request().toBlocking().materialize()
                    }
                    it("it fails with error", closure: {
                        result?.assertSequenceDidFail()
                    })
                })
            })
        }
    }
}

private let mockData = MockData().getData()
