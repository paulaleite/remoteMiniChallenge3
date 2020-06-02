//
//  Person.swift
//  RemoteMC3
//
//  Created by Paula Leite on 02/06/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

struct Person {
    var name: String
    var email: String
    var image: String
    
    init(name: String, email: String, image: String) {
        self.name = name
        self.email = email
        self.image = image
    }
}
