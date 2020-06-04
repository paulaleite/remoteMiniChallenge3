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
//    var responsible: User = User(id: "12345", name: "Teste", email: "Test", projects: nil, projectsWithMe: nil)
//	var users: [User] =  []
	
	var pickerViewDataSource = ["Social", "Cultural", "Pessoal", "Empresarial", "Pesquisa"]
	var phasesName: [String] = [""]
    
    let serverService: ServerService
	
	init(project: Project) {
		self.project = project
        serverService = ServerService()
		//        setUsers()
		phasesName.removeAll()
		for number in 0..<getNumberOfPhases() {
			phasesName.append(getPhase(index: number))
		}
        
        title = project.title
        description = project.description
        organization = project.organization
        start = project.start
        end = project.end
        category = project.category
        phases = project.phases
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
        guard let projectID = project?._id else { return }
        serverService.deleteProject(projectID: projectID, {(response) in
            switch response {
            case .success(_):
                print("Projeto excluido com sucesso!")
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
	}
	
	func saveProject() {
		//TODO: Atualizar os dados do servidor
        project?.title = title
        project?.organization = organization
        project?.description = description
        project?.start = start
        project?.end = end
        project?.category = category
        project?.phases = phases
        guard let project = project else { return }
        serverService.updateProject(project: project, {(response) in
            switch response {
            case .success(let res):
                print(res)
            case .failure(let error):
                print(error)
            }
        })
	}
}
