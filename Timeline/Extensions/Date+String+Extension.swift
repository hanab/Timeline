//
//  Date+String+Extension.swift
//  Timeline
//
//  Created by Hana  Demas on 9/28/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import Foundation

// MARK: - converting string into date
extension String {
    
    func getDateFromString() -> Date? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormat.date(from: self)
    }
}

// MARK: - converting date into date and time string
extension Date {
    
    func getDateStringFromDate() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        return dateFormat.string(from: self)
    }
    
    func getTimeStringFromDate() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm"
        return dateFormat.string(from: self)
    }
}

// MARK: - sequence extention used to group arrays of events by date(date without time)
public extension Sequence {
    
    func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var categories: [U: [Iterator.Element]] = [:]
        
        for element in self {
            let key = key(element)
            if case nil = categories[key]?.append(element) {
                categories[key] = [element]
            }
        }
        return categories
    }
}
