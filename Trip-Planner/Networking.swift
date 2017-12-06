//
//  Networking.swift
//  Trip-Planner
//
//  Created by djchai on 12/6/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import Foundation

/*
 Parts of the HTTP Request
 1. Request Method: GET, PUT, DELETE or POST
 2. Header
 3. URL Path
 4. URL Parameters
 5. Body
 */


// 1 HTTP Methods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// Generate authorization headers to have access to the database
struct basicAuth {
    
    // 2 Generate basic auth header in the format required by the server
    static func generateBasicAuthHeader(username: String, password: String) -> String {
        
        // create a formatted string username:password
        let loginString = String(format: "%@:%@", username, password)
        // encode the string into 'utf-8' format
        guard let loginData: Data = loginString.data(using: String.Encoding.utf8)
            else { return "Error no log in data" }
        // encode utf-8 into base64 format
        let base64LoginString = loginData.base64EncodedString(options: .init(rawValue: 0))
        // set the base64 string as the auth header by using Basic Auth format
        let authHeaderString = "Basic \(base64LoginString)"
        
        return authHeaderString
    }
}

enum Route {
    case users()
    case trips()
    
    // 3 URL path to use for routes
    func path() -> String {
        switch self {
        case .users():
            return "/users"
        case .trips():
            return "/trips"
        }
    }
    
    // 4 URL Parameters to pass if any
    func urlParams() -> [String: String] {
        switch self {
        case .users():
            return ["":""]
        case .trips():
            return ["":""]
        }
    }
    
    // 5 json Body
    func body(user: User? = nil, trip: Trip? = nil) -> Data? {
        switch self {
        case .users():
            var jsonBody = Data()
            do {
                // encode the user object into a json object
                jsonBody = try JSONEncoder().encode(user)
            } catch {}
            return jsonBody
        case .trips():
            var jsonBody = Data()
            do {
                // encode the trip object into a json object
                jsonBody = try JSONEncoder().encode(trip)
            } catch {}
            return jsonBody
        }
    }
}




