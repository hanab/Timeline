//
//  HealthPrompt.swift
//  Timeline
//
//  Created by Hana  Demas on 9/19/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import Foundation
import SwiftyJSON

//MARK Health prompt struct
struct HealthPrompt {
    //MARK: Properties
    var uuid: String
    var message: String
    var displayCategory: String
    var isPermanent: Bool
    var link: Link?
}

//MARK Health Prompt extension to construct from API Response
extension HealthPrompt {
    
    //MARK: Init
    init?(json: JSON) {
        let uuid = json["uuid"].string ?? ""
        let message = json["message"].string ?? ""
        let diplayCategory = json["display_category"].string ?? ""
        let isPermanent = json["permanent"].bool ?? false
        let metadeta = json["metadata"]
        let link = metadeta["link"]
        
        self.uuid = uuid
        self.message = message
        self.displayCategory = diplayCategory
        self.isPermanent = isPermanent
        self.link = Link(json: link)
    }
}

//MARK: Link struct to be constructed from json
struct Link {
    
    //MARK: Properties
    var title: String
    var url: String
    
    //MARK:
    init(json: JSON) {
        let title = json["title"].string ?? ""
        let url = json["url"].string ?? ""
        
        self.title = title
        self.url = url
    }
}
