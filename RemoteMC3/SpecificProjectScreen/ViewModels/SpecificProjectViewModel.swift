//
//  SpecificProjectViewModel.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 15/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class SpecificProjectViewModel {
    
	var project: Project?
    
	init(project: Project) {
		self.project = project
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
	
//	func getProjectOrganization() -> String {
//		return project? ?? "nil"
//	}
	
	func getPhase(index: Int) -> String {
		return project?.phases[index] ?? "nil"
	}
	
	func getResponsible() -> String{
		return project?.responsible.responsibleName ?? "nil"
	}
	func getUser(index: Int) -> String {
		return project?.users[index] ?? "nil"
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
	
}

