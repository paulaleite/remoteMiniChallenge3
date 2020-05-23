//
//  MembersViewController.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 19/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class MemberViewController: UIViewController {
	
	var viewModel: MemberViewModel?
	var notification: Notification?
	
	@IBOutlet var memberName: UILabel!
	@IBOutlet var memberImage: UIImageView!
	@IBOutlet var memberEmail: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.viewModel = MemberViewModel(notification: self.notification!)
		setUpScreen()
		self.title = viewModel?.getProjectName()
    }
	
	func setUpScreen() {
		memberImage.layer.cornerRadius = 125
		memberImage.image = UIImage(named: viewModel?.getMemberImage() ?? "personalColored")
		memberName.text = viewModel?.getMemberName()
		memberEmail.text = viewModel?.getMemberEmail()
	}
	
	@IBAction func aceptAction(_ sender: Any) {
	//TODO: Aceitar no servidor
	}
	
	@IBAction func denyAction(_ sender: Any) {
	//TODO: Negar no servidor
	}
}
