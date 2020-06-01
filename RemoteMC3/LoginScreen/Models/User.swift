//
//  User.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 11/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

struct User: Codable {
    let _id: String?
    let name: String
    let email: String
    let projects: [String]?
    let projectsWithMe: [String]?
    

    init(id: String, name: String, email: String, projects: [String]?, projectsWithMe: [String]?) {
        self._id = id
        self.name = name
        self.email = email
        self.projects = projects
        self.projectsWithMe = projectsWithMe
    }
}
