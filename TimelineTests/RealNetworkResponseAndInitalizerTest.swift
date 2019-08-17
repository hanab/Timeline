//
//  RealNetworkResponseAndInitalizerTest.swift
//  TimelineTests
//
//  Created by Hana  Demas on 9/29/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Timeline


class RealNetworkResponseAndInitalizerTest: XCTestCase {
    
    //MARK: Properties
    fileprivate var apiGetway:APIGetway!
    
    override func setUp() {
        super.setUp()
        apiGetway = APIGetway(session: URLSession.shared)
    }
    
    override func tearDown() {
        apiGetway = nil
    }
    
    //MARK: TestCases
    func testAPIResponse() {
        let testExpectation =  expectation(description: "timeline response expectation")
        apiGetway.fetchDataFromUrl(endpoint: ProfileAPI.profile, completion: {(result) in
            switch result {
            case let .Success(profile):
                XCTAssert(profile.count > 0, "no profile found")
                testExpectation.fulfill()
            case let .Failure(error):
                print(error?.localizedDescription ?? "error")
            }
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    //test initalizer of the Profile object
    func testProfileInitalizer() {
        if let path = Bundle.main.path(forResource: "profile", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [AnyObject]
                let j: JSON = JSON(jsonResult[0])
                let profile = Profile.init(json: j)
                XCTAssertEqual(profile?.id, "freemium_profile", "The profile id is wrong")
                XCTAssertEqual(profile?.firstName, "Otto", "The firstname is wrong")
                XCTAssertEqual(profile?.lastName, "Nova", "The lastname is wrong")
                XCTAssertEqual(profile?.displayName, "Otto Nova", "The display name is wrong")
                XCTAssertEqual(profile?.gender, "male", "The gender is wrong")
                XCTAssertEqual(profile?.trafficLabel, "First Class", "The traffic Label is wrong")
                XCTAssertEqual(profile?.isPrimeryProfile, true, "The profile id is wrong")
            } catch {
                print("json parsing failed")
            }
        }
    }
}
