//
//  TestLogic.swift
//  TimelineTests
//
//  Created by Hana  Demas on 9/30/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import Timeline

class TestLogic: XCTestCase {
    
    func testEventsGroupingByDate() {
        let event1 = Event(uuid: "0", timeStamp: "2018-03-01T08:00:00+00:00", displayCategory: "cat1", title: "title1", description: "bla bal", category: "catagory1")
        let event2 = Event(uuid: "2", timeStamp: "2018-03-01T08:09:00+00:00", displayCategory: "cat2", title: "title2", description: "bla bal 2", category: "catagory2")
        let event3 = Event(uuid: "1", timeStamp: "2017-03-01T08:00:00+00:00", displayCategory: "cat3", title: "title3", description: "bla bal3", category: "catagory3")
        
        let eventsArray:[Event] = [event1, event2, event3]
        let eventByDate: [String: [Event]] = eventsArray.group {$0.dateTimeTuple.0}
        
        XCTAssertEqual(eventByDate.count, 2, "number of different days is wrong")
        XCTAssertEqual(eventByDate["2018-03-01"]?.count, 2, "number of evnets on 2018-03-01 is wrong")
        XCTAssertEqual(eventByDate["2017-03-01"]?.count, 1, "number of evnets on 2017-03-01 is wrong")
    }
}
