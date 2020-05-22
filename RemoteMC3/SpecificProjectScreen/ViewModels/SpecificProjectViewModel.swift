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
	
}
