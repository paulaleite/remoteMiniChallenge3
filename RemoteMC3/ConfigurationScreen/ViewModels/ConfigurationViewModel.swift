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
    var projects: [ConfigurationProject] = []

    func getProjectsRowsNumber() -> Int {
        return projects.count
    }

    func getNameOfProject(forConfigurationProjectAt index: Int) -> String{
        return projects[index].title
    }
    
    func getProjectResponsable(forConfigurationProjectAt index: Int) -> String {
        return projects[index].responsable
    }

    func getProjectPhase(forConfigurationProjectAt index: Int) -> String {
        return projects[index].phase
    }
	
	func setProjects() {
		projects.append(ConfigurationProject(title: "Projeto", responsable: "Edgar Sgroi Rocha Lindo da Silva", phase: "ähhahahhahahhhahahahha jaaajajjah usus"))
	}
}

