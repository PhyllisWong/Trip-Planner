//  Networking.swift
//  Trip-Planner
//  Created by Phyllis Wong on 12/6/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.


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

// user: User? = nil, trip: Trip? = nil, httpMethod: HTTPMethod

enum Route {
    case loginUser(email: String, password: String)
    case createUser(user: User)
    case getTrips
    case createTrip(trip: Trip)
    case deleteTrip(destination: String)
    
    // #1 HTTP Method
    func httpMethod() -> HTTPMethod {
        switch self {
        case .loginUser:
            return .get
        case .createUser:
            return .post
        case .getTrips:
            return .get
        case .createTrip:
            return .post
        case .deleteTrip:
            return .delete
        }
    }
    
    // #2
    func header(token: String) -> [String: String] {
        switch self {
        case .loginUser, .createUser, .getTrips, .createTrip, .deleteTrip:
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
        case .createUser, .loginUser:
            return "/users"
        case .getTrips, .createTrip, .deleteTrip:
            return "/trips"
        }
    }
    
    // 4 URL Parameters to pass if any
    func urlParams() -> [URLQueryItem] {
        switch self {
        case .createUser, .loginUser:
            return []
        case .getTrips, .createTrip:
            return []
        case .deleteTrip(let destination):
            return [URLQueryItem(name: "destination", value: destination)]
            
        }
    }
    
    // 5 json Body
    func body() -> Data? {
        switch self {
        case let .createUser(user):
            var jsonBody = Data()
            do {
                // encode the user object into a json object
                jsonBody = try JSONEncoder().encode(user)
            } catch {}
            
            return jsonBody
            
        case let .createTrip(trip):
            var jsonBody = Data()
            do {
                // encode the trip object into a json object
                jsonBody = try JSONEncoder().encode(trip)
            } catch {}
            
            return jsonBody
            
        default: return nil
        }
        
    }
}

class Networking {
    // local server...switch to public API after testing
    // Networking method
    
    static func fetch(route: Route, completionHandler: @escaping(Data, Int) -> Void) {
        
        // Setting the url string and appending the path
        let baseURL = "http://127.0.0.1:5000/"
        let fullURLString = URL.init(string: baseURL.appending(route.path()))
        
        // Appending the URL Params using the KeyChainSwift library
        let requestURLString = fullURLString?.appendingPathComponent(route.path())
        
        var components = URLComponents(url: requestURLString!, resolvingAgainstBaseURL: true)
        components?.queryItems = route.urlParams()
        
        var request = URLRequest(url: components!.url!)
        request.allHTTPHeaderFields = route.header(token: "Basic dGVzdDp0ZXN0")
        request.httpMethod = route.httpMethod().rawValue
        
        request.httpBody = route.body()
        
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





