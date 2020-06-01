//
//  ConfigurationViewModel.swift
//  RemoteMC3
//
//  Created by Luiza Fattori on 15/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class ConfigurationViewModel {
	
    var projectsWithMe: [Project] = []
	var myProjects: [Project] = []
	var sectionNames: [String] = ["Projetos que criei", "Projetos que participo"]
    let serverService: ServerService = ServerService()
    
	func getProject(type: [Project], index: Int) -> Project {
		return type[index]
	}
	
    func getProjectsWithMeItensNumber() -> Int {
        return projectsWithMe.count
    }
	
	func getMyProjectsItensNumber() -> Int {
        return myProjects.count
    }

    func getNameOfProject(index: Int) -> String {
		return projectsWithMe[index].title
    }
    
    func getProjectResponsable(index: Int) -> String {
		return projectsWithMe[index].responsible.responsibleName
    }

    func getProjectPhase(index: Int) -> String {
		return projectsWithMe[index].phases[0]
    }
	
	func getNameOfMyProject(index: Int) -> String {
		return myProjects[index].title
    }
    
    func getMyProjectResponsable(index: Int) -> String {
		return myProjects[index].responsible.responsibleName
    }

    func getMyProjectPhase(index: Int) -> String {
        return myProjects[index].phases.count > 0 ? myProjects[index].phases[0] : "Sem etapas"
    }
	
	func setMyProjects() {
        guard let userID = UserDefaults.standard.string(forKey: "userIDServer") else { return }
        //TODO: Mudar por método que só procura 1 usuário, e não um array
        serverService.getUsersBy(users: [userID], {(response) in
            switch response {
            case .success(let resp):
                guard let user = resp.result.first else { return }
                guard let projects = user.projects else { return }
                self.serverService.getProjectsBy(projects: projects, {(result) in
                    switch result {
                    case .success(let res):
                        self.myProjects = res.result
						self.myProjects.reverse()
                        NotificationCenter.default.post(name: NSNotification.Name("reload_configuration"), object: nil)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
	}
    
    func setProjectsWithMe() {
        guard let userID = UserDefaults.standard.string(forKey: "userIDServer") else { return }
        //TODO: Mudar por método que só procura 1 usuário, e não um array
        serverService.getUsersBy(users: [userID], {(response) in
            switch response {
            case .success(let resp):
                guard let user = resp.result.first else { return }
                guard let projects = user.projectsWithMe else { return }
                self.serverService.getProjectsBy(projects: projects, {(result) in
                    switch result {
                    case .success(let res):
                        self.projectsWithMe = res.result
                        self.projectsWithMe.reverse()
                        NotificationCenter.default.post(name: NSNotification.Name("reload_configuration"), object: nil)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
