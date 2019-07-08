//
//  GetEmployeeInfoHandlerTests.swift
//  EmployeeRosterTests
//
//  Created by Nischal Hada on 7/7/19.
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

class GetEmployeeInfoHandlerTests: QuickSpec {
    
    override func spec() {
        var testRequest: GetEmployeeInfoHandler!
        var mockWebService: MockWebServiceProtocol!
        
        describe("GetEmployeeInfoHandlerTests") {
            beforeEach {
                mockWebService = MockWebServiceProtocol()
                stub(mockWebService, block: { stub in
                    when(stub.request(with: any())).thenReturn(Observable.just(Data()))
                })
                testRequest = GetEmployeeInfoHandler(withWebService: mockWebService)
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
