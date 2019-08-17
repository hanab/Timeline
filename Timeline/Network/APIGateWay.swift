//
//  APIGateWay.swift
//  Timeline
//
//  Created by Hana  Demas on 9/24/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import Foundation

import Foundation

// Response from Profile API
enum ProfileAPIResult {
    case Success([AnyObject])
    case Failure(Error?)
}

class APIGetway {
    
    //MARK: Properties
    private let session: NetworkSessionProtocol
    
    //MARK: Init
    init(session: NetworkSessionProtocol) {
        self.session = session
    }
    
    //MARK: Functions
    func fetchDataFromUrl(endpoint: ProfileAPI, completion: @escaping (_ json: ProfileAPIResult) -> ()) {
        let request = URLRequest(url: endpoint.constructURL(parameters: nil))
        let task = session.sessionDataTask(with: request, completionHandler:  { (data, response, error) -> Void in
            
            let results = self.processProfileRequest(data: data, error: error)
            completion(results)
        })
        task.resume()
    }
    
    //Get response data
    fileprivate func processProfileRequest(data: Data?, error: Error?) -> ProfileAPIResult {
        guard let data = data else {
            return .Failure(error)
        }
        
        do {
            if  let json = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject] {
                return .Success(json)
            } else {
                return .Failure(error)
            }
        } catch {
            return .Failure(error)
        }
    }
}
