//
//  Networking.swift
//  Trip-Planner
//
//  Created by djchai on 12/6/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import Foundation
import UIKit

/*
 Parts of the HTTP Request
 1. Request Method: GET, PUT, DELETE or POST
 2. Header
 3. URL Path
 4. URL Parameters
 5. Body
 */

// Generate authorization headers for http methods and sanitize code for helper functions
struct basicAuth {
    
    static func generateBasicAuthHeader(username: String, password: String) -> String {
        let loginString = String(format: "%@:%@", username, password)
        guard let loginData: Data = loginString.data(using: String.Encoding.utf8)
            else { return "Error no log in data" }
        let base64LoginString = loginData.base64EncodedString(options: .init(rawValue: 0))
        let authHeaderString = "Basic \(base64LoginString)"
        
        return authHeaderString
    }
}


// 1 HTTP Requests
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Resource {
    case createUser
    case loginUser
    case createTrip
    case showTrip
    case deleteTrip(destination: String)
    
    func httpMethod() -> HTTPMethod {
        switch self {
        case .createUser, .createTrip:
            return .post
        case .loginUser:
            return .get
        case .showTrip:
            return .get
        case .deleteTrip:
            return .delete
        }
    }
    
    // 2 Headers
    func headers() -> [String: String]{
        switch self {
        case .loginUser:
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "", // what goes here?
                    "Host": "http://127.0.0.1:5000/trips"
                ]
        case .createUser, .createTrip:
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "", // what goes here?
                    "Host": "http://127.0.0.1:5000/trips"
                ]
        case .showTrip:
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "", // what goes here?
                    "Host": "http://127.0.0.1:5000/trips"
                ]
        case .deleteTrip:
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "", // what goes here?
                    "Host": "http://127.0.0.1:5000/trips"
                ]
        }
    }
    
    // 3 Path
    
    func path() -> String {
        switch self {
        case .createUser, .loginUser:
            return "/users"
        case .createTrip, .showTrip:
            return "/trips"
        case .deleteTrip(let destination):
            return "/trips\(destination)"
        }
    }
    
    // 4 URL Parameters
    func urlParams() -> [String: String] {
        switch self {
        case .createUser, .createTrip:
            return [:]
        case .loginUser:
            return [:]
        case .showTrip:
            return [:]
        case .deleteTrip:
            return [:]
        }
    }
    
    // 5 Body
    func body() {
        
    }
}



