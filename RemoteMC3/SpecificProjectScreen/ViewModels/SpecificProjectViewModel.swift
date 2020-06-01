//
//  SpecificProjectViewModel.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 15/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

protocol SpecificProjectViewModelDelegate: class {
	func addSucessAlert()
	func addErrorAlert()
}

class SpecificProjectViewModel {
    
	var project: Project?
    var users: [User]?
    var serverService: ServerService
	weak var delegate: SpecificProjectViewModelDelegate?
	
	init(project: Project) {
		self.project = project
        serverService = ServerService()
        setUsers()
	}
    
    func setUsers() {
        guard let project = project else { return }
        serverService.getUsersBy(users: project.users, {(res) in
            switch res {
            case .success(let response):
                self.users = response.result
                NotificationCenter.default.post(name: NSNotification.Name("update_users"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
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
	
	func getPhase(index: Int) -> String {
		return project?.phases[index] ?? "nil"
	}
	
	func getResponsible() -> String {
		return project?.responsible.responsibleName ?? "nil"
	}
	func getUser(index: Int) -> User? {
        return users?[index] ?? nil
	}

	func getStart() -> String {
		return project?.start ?? "nil"
	}
	
	func getEnd() -> String {
		return project?.end ?? "nil"
	}
	
	func getNumberOfUsers() -> Int {
		return project?.users.count ?? 0
	}
	
	func getNumberOfPhases() -> Int {
		return project?.phases.count ?? 0
	}
	
    func requireParticipation() {
        //TODO: Mudar userID para o usuário atual
        guard let userID = UserDefaults.standard.string(forKey: "userIDServer") else { return }
        guard let userName = UserDefaults.standard.string(forKey: "userNameServer") else { return }
        guard let userEmail = UserDefaults.standard.string(forKey: "userEmailServer") else { return }
        if let id = project?._id {
            serverService.requireParticipation(projectID: id, userID: userID, userName: userName, userEmail: userEmail, {(result) in
                switch result {
                case .success(_):
                    //TODO: mostrar resposta para o usuário
                    print("Solicitação enviada com sucesso!")
					self.delegate?.addSucessAlert()
                case .failure(let error):
                    print(error.localizedDescription)
					self.delegate?.addErrorAlert()
                }
            })
        }
    }
}

