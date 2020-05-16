//
//  CreateProjectViewController.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 14/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class CreateProjectViewController: UIViewController {
	
	var viewModel = CreateProjectViewModel()
	
	@IBOutlet var projectTitle: UITextField!
	@IBOutlet var projectInstitution: UITextField!
	@IBOutlet var projectDescryption: UITextView!
	@IBOutlet var projectStart: UITextField!
	@IBOutlet var projectEnd: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	@IBAction func createProjectAction(_ sender: Any) {
		viewModel.createProject(title: projectTitle.text ?? "", description: projectDescryption.text ?? "", college: College(name: projectInstitution.text ?? ""),
								responsible: User(firstName: "Cassia", lastName: "Barbosa"), members: [User(firstName: "Cassia", lastName: "Barbosa")],
								duration: (Date(), Date()), category: "Social")
	}
}
