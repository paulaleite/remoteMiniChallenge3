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
	@IBOutlet var usersCollectionView: UICollectionView!
	@IBOutlet var phasesTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		usersCollectionView.delegate = self
		usersCollectionView.dataSource = self
		
		phasesTableView.dataSource = self
		
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
		return viewModel.getProject().members.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let specificProjectCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecificProjectCollectionCell",
																				  for: indexPath) as? SpecificProjectCollectionCell {
			specificProjectCollectionCell.userName.text  = viewModel.getProject().members[indexPath.row].firstName + " "
				+ viewModel.getProject().members[indexPath.row].lastName
			
			specificProjectCollectionCell.userPhoto.image = UIImage(named: viewModel.getProject().image)
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
		return viewModel.getProject().phases.count
    }
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let specificProjectTableCell = tableView.dequeueReusableCell(withIdentifier: "SpecificProjectTableCell", for: indexPath) as? SpecificProjectTableCell {
			specificProjectTableCell.phaseDescription.text = "  " + viewModel.getProject().phases[indexPath.section].title
			specificProjectTableCell.phaseDescription.layer.cornerRadius = 5
			specificProjectTableCell.phaseDescription.layer.borderColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
			specificProjectTableCell.phaseDescription.layer.borderWidth = 0.5
						
			return specificProjectTableCell
		}
		return UITableViewCell()
	}
}
