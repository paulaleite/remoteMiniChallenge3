//
//  Project.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 11/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

struct Project: Codable {
    var phases: [String]
    var users: [String]
    var title: String
    var organization: String?
    var description: String
    var start: String
    var end: String
    var category: String
    var responsible: Responsible
}
