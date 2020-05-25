//
//  CreateProjectViewModel.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 15/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class CreateProjectViewModel {
    
    let serverService = ServerService()
	
	var title: String = " "
	var description: String = ""
    var organization: String?
	var start: String = ""
	var end: String = ""
    var category: String = ""
	var phases: [String] = []
    var responsible: User = User(id: "12345", name: "Teste", email: "Test", projects: nil)
	var users: [User] =  []
	
	var pickerViewDataSource = ["Social", "Cultural", "Pessoal", "Empresarial", "Pesquisa"]
	var phasesName: [String] = [" "]
	
    func createProject() {
		if (title != "") && (description != "") {
            let project = Project(phases: phases,
                                  users: ["5ec5844c97ebd90017446121"],
                                  title: title,
                                  organization: organization,
                                  description: description,
                                  start: start,
                                  end: end,
                                  category: category,
                                  responsible: Responsible(responsibleId: "5ec586da97ebd90017446122", responsibleName: responsible.name))
            
            serverService.createProject(project: project, {(response) in
                switch response {
                case .success(_):
                    print("Projeto cadastrado com sucesso!")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
		}
	}
	
	func validateProject() {
		
	}
	
}
