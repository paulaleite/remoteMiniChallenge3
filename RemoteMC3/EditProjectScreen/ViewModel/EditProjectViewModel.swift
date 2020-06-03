//
//  EditProjectViewModel.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 01/06/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

protocol EditProjectViewModelDelegate: class {
	func addSucessAlert()
	func addErrorAlert()
}

class EditProjectViewModel {
	
	weak var delegate: EditProjectViewModelDelegate?
	var project: Project?
	var title: String = " "
	var description: String = ""
    var organization: String?
	var start: String = ""
	var end: String = ""
    var category: String = ""
	var phases: [String] = []
    var responsible: User = User(id: "12345", name: "Teste", email: "Test", projects: nil, projectsWithMe: nil)
	var users: [User] =  []
	
	var pickerViewDataSource = ["Social", "Cultural", "Pessoal", "Empresarial", "Pesquisa"]
	var phasesName: [String] = [""]
	
	init(project: Project) {
		self.project = project
		//        serverService = ServerService()
		//        setUsers()
		phasesName.removeAll()
		for number in 0..<getNumberOfPhases() {
			phasesName.append(getPhase(index: number))
		}
	}
	
	func getProject() -> Project {
		return project!
	}
	
	func getProjectTitle() -> String {
		return project?.title ?? "nil"
	}
	
	func getProjectDescription() -> String {
		return project?.description ?? "nil"
	}
	
	func getProjectOrganization() -> String {
		return project?.organization ?? "nil"
	}
	func getProjectCategory() -> String {
		return project?.category ?? "nil"
	}
	
	func getPhase(index: Int) -> String {
		return project?.phases[index] ?? "nil"
	}
	
	func getStart() -> String {
		return project?.start ?? "nil"
	}
	
	func getEnd() -> String {
		return project?.end ?? "nil"
	}
	
	func getNumberOfPhases() -> Int {
		return project?.phases.count ?? 0
	}
	
	func deleteProject() {
		//TODO: Atualizar os dados do servidor
	}
	
	func saveProject() {
		//TODO: Atualizar os dados do servidor
	}
}
