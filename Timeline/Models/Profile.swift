//
//  Profile.swift
//  Timeline
//
//  Created by Hana  Demas on 9/19/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import Foundation
import SwiftyJSON

//MARK: Profile struct
struct Profile {
    
    //MARK: Properties
    var id: String
    var firstName: String
    var lastName: String
    var gender: String
    var displayName: String
    var isPrimeryProfile: Bool
    var trafficLabel: String
    var attrbuits: [String] = [String]()
    //attributes to get using profile ID from API
    var healthPrompts: [HealthPrompt] = [HealthPrompt]()
    var events: [Event] = [Event]()
}

//MARK: profile extension to get profile from json
extension Profile {
    
    //MARK: Init
    init?(json: JSON) {
        let id = json["profile_id"].string ?? ""
        let firstName = json["first_name"].string ?? ""
        let lastName = json["last_name"].string ?? ""
        let gender = json["gender"].string ?? ""
        let displayName = json["display_name"].string ?? ""
        let isPrimaryProfile = json["is_primary_profile"].bool ?? false
        let trafficLabel = json["tariff_label"].string ?? ""
        let attrbuits = json["profile_attributes"].arrayObject ?? [String]()
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.displayName = displayName
        self.isPrimeryProfile = isPrimaryProfile
        self.trafficLabel = trafficLabel
        for attrbuit in attrbuits {
            self.attrbuits.append(attrbuit as? String ?? "")
        }
    }
}
