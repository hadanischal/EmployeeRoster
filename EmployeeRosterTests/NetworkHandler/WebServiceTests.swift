//
//  WebServiceTests.swift
//  EmployeeRosterTests
//
//  Created by Nischal Hada on 15/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Cuckoo
import Nimble
import OHHTTPStubs
import Quick
import RxBlocking
import RxSwift
import RxTest
import XCTest

@testable import EmployeeRoster

class WebServiceTests: QuickSpec {
    override func spec() {
        var testRequest: WebService!
        var mockResource: Resource!
        let url = "/roster"

        describe("GetEmployeeInfoHandlerTests") {
            beforeEach {
                mockResource = Resource(url: URL(string: url)!, parameters: nil)
                testRequest = WebService()
            }

            describe("Get Employee Info from server", {
                context("when server request succeed ", {
                    var result: MaterializedSequenceResult<Data>?
                    beforeEach {
                        stub(condition: isPath(url)) { request -> HTTPStubsResponse in
                            expect(request.httpMethod) == "GET"
                            return HTTPStubsResponse(data: mockData!,
                                                     statusCode: 201,
                                                     headers: ["Content-Type": "application/json"])
                        }
                        result = testRequest.request(with: mockResource).toBlocking(timeout: 2).materialize()
                    }
                    it("it completed successfully", closure: {
                        result?.assertSequenceCompletes()
                    })
                })

                context("when server request failed ", {
                    var result: MaterializedSequenceResult<Data>?
                    beforeEach {
                        stub(condition: isPath(url)) { request -> HTTPStubsResponse in
                            expect(request.httpMethod) == "GET"
                            return HTTPStubsResponse(data: Data(),
                                                     statusCode: 400,
                                                     headers: ["Content-Type": "application/json"])
                        }
                        result = testRequest.request(with: mockResource).toBlocking(timeout: 2).materialize()
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
