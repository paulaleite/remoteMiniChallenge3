//
//  Member.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 19/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

struct Member {
    var name: String
	var email: String
	var image: String
    
	init(name: String, email: String, image: String) {
        self.name = name
        self.email = email
		self.image = image
    }
}
