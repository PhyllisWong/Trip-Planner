//
//  Trip.swift
//  Trip-Planner
//
//  Created by djchai on 12/6/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import Foundation

struct Trip {
    let destination: String?
    let waypoints: [String?]
    let completed: Bool
 
}

extension Trip: Decodable {
    
    enum TripKeys: String, CodingKey {
        case destination
        case waypoints
        case completed
    }
    
    // Decode the json from the server to swift
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TripKeys.self)
        let destination = try container.decode(String.self, forKey: .destination)
        let waypoints = try container.decode([String].self, forKey: .waypoints)
        let completed = try container.decode(Bool.self, forKey: .completed)
        self.init(destination: destination, waypoints: waypoints, completed: completed)
    }
}

extension Trip: Encodable {
    
    // Encode the swift data to json
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TripKeys.self)
        try container.encode(destination, forKey: .destination)
        try container.encode([waypoints], forKey: .waypoints)
        try container.encode(completed, forKey: .completed)
    }
}




