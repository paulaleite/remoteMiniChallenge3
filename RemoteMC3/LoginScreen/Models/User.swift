//
//  User.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 11/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: String
    let email: String
    let projects: [String]?
    
    init(name: String, email: String, projects: [String]?) {
        self.name = name
        self.email = email
        self.projects = projects
    }
}
