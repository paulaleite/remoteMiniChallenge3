//
//  CreateProjectViewModel.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 15/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

protocol CreateProjectViewModelDelegate: class {

}

class CreateProjectViewModel {
	
	var title: String = " "
	var description: String = ""
	var start: String = ""
	var end: String = ""
	var phases: [String] = []
	var responsible: User = User(name: "Teste", email: "Test", projects: nil)
	var users: [User] =  []
	
	var pickerViewDataSource = ["Social", "Cultural", "Pessoal", "Empresarial", "Pesquisa"]
	var phasesName: [String] = [" "]
	
    func createProject(title: String, description: String, start: String, end: String, phases: [String], responsible: User, users: [User]) {
		
		if (title != "") && (description != "") {
			self.title = title
			self.description = description
			self.start = start
			self.end = end
			self.phases = phases
            self.responsible = responsible
			self.users = users
		}
	}
	
}
