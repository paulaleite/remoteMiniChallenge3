//
//  Project.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 11/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

struct Project {
    var title: String
    var description: String
    var college: College
    var responsible: User
    var members: [User]
    var duration: (Date, Date)
    var currentPhase: Phase
    var phases: [Phase]

}
