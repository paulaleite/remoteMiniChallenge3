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
	
	var title: String = ""
	var description: String = ""
	var firstName: String = ""
	var lastName: String = ""
	var category: String = ""
	var college: College = College(name: "")
	var duration: (Date, Date) =  (Date(), Date())
	var currentPhase: Phase = Phase(title: "")
	var phases: [Phase] = [Phase(title: "")]
	
	var pickerViewDataSource = ["Social", "Cultural", "Pessoal", "Empresarial", "Pesquisa"]
	
	func createProject(title: String, description: String, college: College, responsible: User, members: [User], duration: (Date, Date), category: String) {
		
		if (title != "") && (description != "") {
			self.title = title
			self.description = description
			self.firstName = responsible.firstName
			self.lastName = responsible.lastName
			self.category = category
//			self.phases = phases
//			self.currentPhase = currentPhase
			self.college = college
			self.category = category
			print(duration)
			
			print(title)
		}
	}
	
}
