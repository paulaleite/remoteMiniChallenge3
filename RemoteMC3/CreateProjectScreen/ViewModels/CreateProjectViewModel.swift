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
	func addSucessAlert()
	func addErrorAlert()
}

class CreateProjectViewModel {
    
    let serverService = ServerService()
	
	weak var delegate: CreateProjectViewModelDelegate?
	
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
	var phasesName: [String] = [" "]
	
    func createProject(_ completion: @escaping () -> Void) {
        guard let userID = UserDefaults.standard.string(forKey: "userIDServer") else { return }
        guard let userName = UserDefaults.standard.string(forKey: "userNameServer") else { return }
		if (title != "") && (description != "") {
            let project = Project(phases: phases,
                                  users: [],
                                  title: title,
                                  organization: organization,
                                  description: description,
                                  start: start,
                                  end: end,
                                  category: category,
                                  responsible: Responsible(responsibleId: userID, responsibleName: userName), solicitations: [])
            
            serverService.createProject(project: project, {(response) in
                switch response {
                case .success(let res):
                    _ = res as? Bool
					self.delegate?.addSucessAlert()
                    DispatchQueue.main.async {
                        completion()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
					self.delegate?.addErrorAlert()
                }
            })
		}
	}
	
	func validateProject() {
		
	}
	
}
