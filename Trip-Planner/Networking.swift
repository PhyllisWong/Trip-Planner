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

//struct basicAuth {
//
//    // 2 Generate basic auth header in the format required by the server
//    static func generateBasicAuthHeader(username: String, password: String) -> String {
//
//        // create a formatted string username:password
//        let loginString = String(format: "%@:%@", username, password)
//        // encode the string into 'utf-8' format
//        guard let loginData: Data = loginString.data(using: String.Encoding.utf8)
//            else { return "Error no log in data" }
//        // encode utf-8 into base64 format
//        let base64LoginString = loginData.base64EncodedString(options: .init(rawValue: 0))
//        // set the base64 string as the auth header by using Basic Auth format
//        let authHeaderString = "Basic \(base64LoginString)"
//
//        return authHeaderString
//    }
//}

enum Route {
    case users()
    case trips()
    
    // #2
    func header(token: String) -> [String: String] {
        switch self {
        case .users():
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "\(token)",
                    "Host": "http://127.0.0.1:5000/users"
            ]
        case .trips():
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "\(token)",
                    "Host": "http://127.0.0.1:5000/users"
            ]
        }
    }
    
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

class Networking {
    // local server...switch to public API after testing
    // Networking method
    
    static func fetch(route: Route, user: User? = nil, trip: Trip? = nil, httpMethod: HTTPMethod, completionHandler: @escaping(Data, Int) -> Void) {
        
        // Setting the url string and appending the path
        let baseURL = "http://127.0.0.1:5000/"
        let fullURLString = URL.init(string: baseURL.appending(route.path()))

        // Appending the URL Params using the KeyChainSwift library
        let requestURLString = fullURLString?.appendingPathComponent(route.path())
        var request = URLRequest(url: requestURLString!)
        
        request.allHTTPHeaderFields = route.header(token: "Basic cGh5bGxpczp0ZXN0")
        request.httpMethod = httpMethod.rawValue
        
        // Check to see if the passed in http method is "POST"
        if user != nil && httpMethod.rawValue == "POST" {
            request.httpBody = route.body(user: user)
        }
        if trip != nil && httpMethod.rawValue == "POST" {
            request.httpBody = route.body(trip: trip)
        }
        
        // Create the URL session
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, err) in
            guard let res = response else { return }
            
            // downcast to get the http status code
            let statusCode: Int = (res as! HTTPURLResponse).statusCode
            if let data = data {
                completionHandler(data, statusCode)
            }
        }.resume()
    }
}






