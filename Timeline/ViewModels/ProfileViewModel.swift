//
//  ProfileViewModel.swift
//  Timeline
//
//  Created by Hana  Demas on 9/26/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import Foundation

class ProfileViewModel {
    
    //MARK:Properties
    fileprivate var profile: Profile?
    fileprivate var eventDays: [String] = [String]()
    fileprivate var eventByDate: [String: [Event]] = [String: [Event]]()
    
    //MARK: Functions
    func getProfileFromAPI(completion: (() -> ())? ) {
        ProfileDataManager.sharedInstance.updateProfileWithEventsAndHealthPrompts {
            self.profile = ProfileDataManager.sharedInstance.profile
            completion?()
        }
    }
    
    //group Events by date to display them as one date events
    func groupEventsByDate () {
        guard let profile = self.profile  else {
            return
        }
        self.eventByDate = profile.events.group {$0.dateTimeTuple.0}
        
        for event in self.eventByDate {
            self.eventDays.append(event.key)
        }
        
        if self.eventDays.count > 1 {
            self.eventDays.sort()
        }
    }
    
    //MARK: functions to prepare data for UITablview
    func getNumberOfDays() -> Int {
        return self.eventDays.count
    }
    
    func getDayAtIndex(index:Int) -> String {
        guard index < self.eventDays.count else {
            return ""
        }
        return self.eventDays[index]
    }
    
    //MARK: functions to prepare data source for UICollectioView
    func getNumberOfEvents(day:String)->Int {
        var count: Int = 0
        
        if let event = self.eventByDate[day] {
            count = event.count
        }
        return count
    }
    
    func getEventAtIndex(day:String, index:Int) -> Event? {
        if let events = eventByDate[day], index < events.count {
            let sortedEvents = events.sorted { $0.dateTimeTuple.1 < $1.dateTimeTuple.1 }
            return sortedEvents[index]
        }
        return nil
    }
    
    //MARK: function to prepare data for UILabel
    func getHealtPromptMessage() -> String {
        if let profile = self.profile, profile.healthPrompts.count > 0 {
            let healthPrompt = profile.healthPrompts[0]
            return healthPrompt.message
        }
        return ""
    }
}
