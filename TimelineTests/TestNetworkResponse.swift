//
//  TestNetworkResponse.swift
//  TimelineTests
//
//  Created by Hana  Demas on 9/29/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import Timeline

class TestNetworkResponse: XCTestCase {
    //MARK: Properties
    fileprivate var apiGateway:APIGetway!
    fileprivate var session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        apiGateway = APIGetway(session: session)
    }
    
    //MARK: TestCases
    func testDataTaskResumeCalled() {
        let dataTask = MockURLSessionDataTask()
        session.mockDataTask = dataTask
        
        apiGateway.fetchDataFromUrl(endpoint: ProfileAPI.profile, completion: {(result) in
            //nothing to do with the results for this test
        })
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testSuccessfullResponse() {
        let data = "{}".data(using: .utf8)
        session.mockData = data
        var actualData: ProfileAPIResult?
        
        apiGateway.fetchDataFromUrl(endpoint: ProfileAPI.profile, completion: {(result) in
           actualData = result
        })
        XCTAssertNotNil(actualData)
    }
}
