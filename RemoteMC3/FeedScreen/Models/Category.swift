//
//  Category.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 13/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

class Category {
	
	var imagem: String = ""
	var name: String = ""
	var count: Int = 0
	init(imagem: String, name: String, count: Int) {
		self.imagem = imagem
		self.name = name
		self.count = count
	}
}
