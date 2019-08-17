//
//  EndPoints.swift
//  Timeline
//
//  Created by Hana  Demas on 9/24/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import Foundation

public typealias HTTParameters = [String:String]

//MARK: API Endpoints
enum ProfileAPI {
    case profile
    case events(profileID: String)
    case healthPrompts(profileID: String)
}

enum Methods: String {
    case get = "GET"
}

//MARK: ProfileAPI extension to construct the full URI for each endpoint
extension ProfileAPI: EndPointType {
    
    //MARK: EndPointType protocole implementation
    var baseURL: String {
        return "https://freemium.ottonova.de/api/user/customer/profiles"
    }
    
    var path: String {
        switch self {
        case .profile:
            return ""
        case .events(let profileID):
            return "/" + profileID  + "/timeline-events"
        case .healthPrompts(let profileID):
            return "/" + profileID + "/health-prompts"
        }
    }
    
    var httpMethod: Methods {
        return .get
    }
    
    func constructURL(parameters: HTTParameters?) -> URL {
        var components = URLComponents(string: self.baseURL + path)!
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "method": httpMethod.rawValue
        ]
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        return components.url!
    }
}
