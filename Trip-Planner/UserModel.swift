//
//  User.swift
//  Trip-Planner
//
//  Created by djchai on 12/6/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import Foundation

struct User {
    let email: String
    let username: String
    let password: String

    init(email: String, username: String, password: String) {
        self.email = email
        self.username = username
        self.password = password
    }
}

extension User: Decodable {
    
    enum UserKeys: String, CodingKey {
        case email
        case username
        case password
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKeys.self)
        let email = try container.decode(String.self, forKey: .email)
        let username = try container.decode(String.self, forKey: .username)
        let password = try container.decode(String.self, forKey: .password)
        
        self.init(email: email, username: username, password: password)
    }
}
