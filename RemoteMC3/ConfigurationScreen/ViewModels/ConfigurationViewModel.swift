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
		return myProjects[index].phases[0]
    }
	
	func setProjects() {
		projectsWithMe.append(Project(phases: ["fase"], users: ["Cassia"], title: "título", organization: "mack", description: "ahah", start: "12/09/2020", end: "12/09/2021", category: "Social", responsible: Responsible(responsibleId: "sjj", responsibleName: "Cassia Barbosa")))
		projectsWithMe.append(Project(phases: ["fase"], users: ["Cassia"], title: "título", organization: "mack", description: "ahah", start: "12/09/2020", end: "12/09/2021", category: "Social", responsible: Responsible(responsibleId: "sjj", responsibleName: "Cassia Barbosa")))
		projectsWithMe.append(Project(phases: ["fase"], users: ["Cassia"], title: "título", organization: "mack", description: "ahah", start: "12/09/2020", end: "12/09/2021", category: "Social", responsible: Responsible(responsibleId: "sjj", responsibleName: "Cassia Barbosa")))
		projectsWithMe.append(Project(phases: ["fase"], users: ["Cassia"], title: "título", organization: "mack", description: "ahah", start: "12/09/2020", end: "12/09/2021", category: "Social", responsible: Responsible(responsibleId: "sjj", responsibleName: "Cassia Barbosa")))
		
		myProjects.append(Project(phases: ["fase"], users: ["Cassia"], title: "título", organization: "mack", description: "ahah", start: "12/09/2020", end: "12/09/2021", category: "Social", responsible: Responsible(responsibleId: "sjj", responsibleName: "Cassia Barbosa")))
		myProjects.append(Project(phases: ["fase"], users: ["Cassia"], title: "título", organization: "mack", description: "ahah", start: "12/09/2020", end: "12/09/2021", category: "Social", responsible: Responsible(responsibleId: "sjj", responsibleName: "Cassia Barbosa")))
		myProjects.append(Project(phases: ["fase"], users: ["Cassia"], title: "título", organization: "mack", description: "ahah", start: "12/09/2020", end: "12/09/2021", category: "Social", responsible: Responsible(responsibleId: "sjj", responsibleName: "Cassia Barbosa")))
	}
}
