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
    let projects: [Project]?
    
    init(name: String, email: String, projects: [Project]?) {
        self.name = name
        self.email = email
        self.projects = projects
    }
}
