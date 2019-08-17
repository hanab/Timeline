//
//  EndPointType.swift
//  Timeline
//
//  Created by Hana  Demas on 9/24/18.
//  Copyright © 2018 ___HANADEMAS___. All rights reserved.
//

import Foundation

//Protocole to be emplemented by Endpoint
protocol EndPointType {
    //MARK: Properties
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: Methods { get }
    
    //MARK: Functions
    func constructURL(parameters: HTTParameters?) -> URL
}
