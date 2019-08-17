//
//  Event.swift
//  Timeline
//
//  Created by Hana  Demas on 9/19/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import Foundation
import SwiftyJSON

//MARK: event struct
struct Event {
    
    //MARK: Properties
    var uuid: String
    var timeStamp: String
    var displayCategory: String
    var title: String
    var description: String
    var category: String
    //this is used for grouping events with data and show the time separetly(chronologically)
    var dateTimeTuple:(String, String) {
        let date = timeStamp.getDateFromString()
        return(date?.getDateStringFromDate() ?? "", date?.getTimeStringFromDate() ?? "")
    }
}

//MARK: Event extension to construct Event from API Response
extension Event {
    
    //MARK: Init
    init?(json:JSON) {
        let uuid = json["uuid"].string ?? ""
        let timeStamp = json["timestamp"].string ?? ""
        let displayCategory = json["display_category"].string ?? ""
        let title = json["title"].string ?? ""
        let description = json["description"].string ?? ""
        let category = json["category"].string ?? ""
        self.uuid = uuid
        self.timeStamp = timeStamp
        self.displayCategory = displayCategory
        self.title = title
        self.description = description
        self.category = category
    }
}
