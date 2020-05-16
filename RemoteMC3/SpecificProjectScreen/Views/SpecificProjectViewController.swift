//
//  SpecificProjectViewController.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 15/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class SpecificProjectViewController: UIViewController {
	
	var viewModel = SpecificProjectViewModel()
	
	@IBOutlet var projectDescryption: UITextView!
	@IBOutlet var projectResponsible: UILabel!
	@IBOutlet var projectStart: UILabel!
	@IBOutlet var projectEnd: UILabel!
	@IBOutlet var projectInstitution: UILabel!
		
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationController?.navigationBar.prefersLargeTitles = true
		self.title = viewModel.getProject().title
		setInformation()

	}
	
	func setInformation() {
		projectDescryption.text = viewModel.getProject().description
		projectResponsible.text = viewModel.getProject().responsible.firstName + " " + viewModel.getProject().responsible.lastName
		projectInstitution.text = viewModel.getProject().college.name
		projectStart.text = viewModel.getProject().duration.0.convertToString(dateformat: .date)
		projectEnd.text = viewModel.getProject().duration.1.convertToString(dateformat: .date)
		
	}

}
