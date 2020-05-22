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
	
	var viewModel: SpecificProjectViewModel?
	var project: Project?
	
	@IBOutlet var projectDescryption: UITextView!
	@IBOutlet var projectResponsible: UILabel!
	@IBOutlet var projectStart: UILabel!
	@IBOutlet var projectEnd: UILabel!
	@IBOutlet var projectInstitution: UILabel!
	@IBOutlet var usersCollectionView: UICollectionView!
	@IBOutlet var phasesTableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.viewModel = SpecificProjectViewModel(project: project!)
		
		usersCollectionView.delegate = self
		usersCollectionView.dataSource = self
		
		phasesTableView.dataSource = self
		
		navigationController?.navigationBar.prefersLargeTitles = true
        self.title = viewModel?.getProject().title
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadUsersCollection), name: NSNotification.Name("update_users"), object: nil)
		
		setInformation()
	}
    
    @objc func reloadUsersCollection() {
        usersCollectionView.reloadData()
    }
	
	func setInformation() {
		projectDescryption.text = viewModel?.getProjectDescription()
		projectResponsible.text = viewModel?.getResponsible()
        projectInstitution.text = "Não existe"
		projectStart.text = viewModel?.getStart()
		projectEnd.text = viewModel?.getEnd()
		
//		remove top space of grouped table view
		var frame = CGRect.zero
		frame.size.height = .leastNormalMagnitude
		phasesTableView.tableHeaderView = UIView(frame: frame)		
	}
}

extension SpecificProjectViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 50, height: 70)
	}
}

extension SpecificProjectViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel?.getNumberOfUsers() ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let specificProjectCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecificProjectCollectionCell", for: indexPath) as? SpecificProjectCollectionCell {
            specificProjectCollectionCell.userName.text  = viewModel?.getUser(index: indexPath.row)?.name
			specificProjectCollectionCell.userPhoto.image = #imageLiteral(resourceName: "personalColored")
			specificProjectCollectionCell.userPhoto.layer.cornerRadius = 25
			
			return  specificProjectCollectionCell
		}
		return SpecificProjectCollectionCell()
	}
}

extension SpecificProjectViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
		
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel?.getNumberOfPhases() ?? 0
    }
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let specificProjectTableCell = tableView.dequeueReusableCell(withIdentifier: "SpecificProjectTableCell", for: indexPath) as? SpecificProjectTableCell {
			specificProjectTableCell.phaseDescription.text = viewModel?.getPhase(index: indexPath.row)
			specificProjectTableCell.phaseDescription.layer.cornerRadius = 5
			specificProjectTableCell.phaseDescription.layer.borderColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
			specificProjectTableCell.phaseDescription.layer.borderWidth = 0.5
						
			return specificProjectTableCell
		}
		return UITableViewCell()
	}
}
