//
//  Response.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 21/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

struct ResponseProjects: Codable {
    let result: [Project]
}

struct ResponseUsers: Codable {
    let result: [User]
}
