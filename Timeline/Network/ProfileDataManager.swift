//
//  ProfileDataManager.swift
//  Timeline
//
//  Created by Hana  Demas on 9/26/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import Foundation
import SwiftyJSON

//MARK: A singlton class to get profile from API
class ProfileDataManager {
    
    //MARK: Properties
    static let sharedInstance = ProfileDataManager()
    fileprivate var apiDelegate = APIGetway(session: URLSession.shared)
    var profile: Profile?
    
    //MARK: Functions
    fileprivate  func getProfile(completion: (() -> ())? ) {
        apiDelegate.fetchDataFromUrl(endpoint: ProfileAPI.profile, completion:{ (result) in
            self.getProfileFromJson(result: result, completion: completion)
        })
    }
    
    //response of Events wont affect response of healthprompt(depends only on profile response)
    func updateProfileWithEventsAndHealthPrompts(completion: (() -> ())? ) {
        self.getProfile {
            if let profileID =  self.profile?.id {
                self.apiDelegate.fetchDataFromUrl(endpoint: ProfileAPI.events(profileID: profileID), completion:{ (result) in
                    self.getEventsFromJson(result: result)
                    
                    self.apiDelegate.fetchDataFromUrl(endpoint: ProfileAPI.healthPrompts(profileID: profileID), completion:{ (result) in
                        self.getHealthPromptsFromJson(result: result)
                        completion?()
                    })
                })
            }
        }
    }
    
    fileprivate func getProfileFromJson(result: ProfileAPIResult,  completion: (() -> ())?) {
        switch result {
        case let .Success(profileJson):
            let j: JSON = JSON(profileJson[0])
            self.profile = Profile.init(json: j)
        case let .Failure(error):
            if let error = error {
                print(error.localizedDescription)
            }
        }
        completion?()
    }
    
    fileprivate func getHealthPromptsFromJson(result: ProfileAPIResult) {
        switch result {
        case let .Success(promptJson):
            for prompt in promptJson {
                let j: JSON = JSON(prompt)
                if let healthPrompt = HealthPrompt.init(json: j) {
                    self.profile?.healthPrompts.append(healthPrompt)
                }
            }
        case let .Failure(error):
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func getEventsFromJson(result: ProfileAPIResult) {
        switch result {
        case let .Success(eventJson):
            for event in eventJson {
                let j: JSON = JSON(event)
                if let event = Event.init(json: j) {
                    self.profile?.events.append(event)
                }
            }
        case let .Failure(error):
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
