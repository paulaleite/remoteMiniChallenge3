//
//  Social.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 13/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class Social: Category {
	var count = 0
	
	init(count: Int) {
		super.init(imagem: "Group 19", name: "Social")
		self.count = count
	}
}
