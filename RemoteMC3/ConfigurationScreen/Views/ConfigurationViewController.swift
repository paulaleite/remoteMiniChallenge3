//
//  ConfigurationViewController.swift
//  RemoteMC3
//
//  Created by Luiza Fattori on 15/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class ConfigurationViewController: UIViewController, UICollectionViewDelegate {
    var viewModel: ConfigurationViewModel = ConfigurationViewModel()

    @IBOutlet weak var projectsCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true

        projectsCollectionView.dataSource = self
		projectsCollectionView.delegate = self
		
        NotificationCenter.default.addObserver(self, selector: #selector(reloadUI), name: NSNotification.Name("reload_configuration"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.setMyProjects()
        viewModel.setProjectsWithMe()
    }
    
    @objc func reloadUI() {
        projectsCollectionView.reloadData()
    }
}

extension ConfigurationViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 2
	}
	
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch section {
		case 0:
			return viewModel.getMyProjectsItensNumber()
		default:
			 return viewModel.getProjectsWithMeItensNumber()
		}
    }
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if let customCollectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CustomCollectionHeader", for: indexPath) as? CustomCollectionHeader {
			customCollectionHeader.sectionName.text = viewModel.sectionNames[indexPath.section]
			
			return customCollectionHeader
		}
		return UICollectionReusableView()

	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let configurationCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "configurationCollectionCell", for: indexPath) as? ConfigurationCollectionCell {
		configurationCollectionCell.layer.masksToBounds = false
		configurationCollectionCell.backgroundColor = .white
		configurationCollectionCell.layer.cornerRadius = 10
		configurationCollectionCell.layer.shadowColor = UIColor.black.cgColor
		configurationCollectionCell.layer.shadowOffset = .zero
		configurationCollectionCell.layer.shadowRadius = 4
		configurationCollectionCell.layer.shadowOpacity = 0.3
			if indexPath.section == 0 {
				configurationCollectionCell.nameProject.text = viewModel.getNameOfMyProject(index: indexPath.row)
				configurationCollectionCell.responsableProject.text = viewModel.getMyProjectResponsable(index: indexPath.row)
				configurationCollectionCell.phaseProject.text = viewModel.getMyProjectPhase(index: indexPath.row)
				return configurationCollectionCell
			} else {
				configurationCollectionCell.nameProject.text = viewModel.getNameOfProject(index: indexPath.row)
				configurationCollectionCell.responsableProject.text = viewModel.getProjectResponsable(index: indexPath.row)
				configurationCollectionCell.phaseProject.text = viewModel.getProjectPhase(index: indexPath.row)
				return configurationCollectionCell
			}
		}
		return UICollectionViewCell()
	}
		
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let specificVC = storyboard.instantiateViewController(withIdentifier: "SpecificProjectViewController") as? SpecificProjectViewController
		
		switch indexPath.section {
		case 0:
			specificVC?.project = viewModel.getProject(type: viewModel.myProjects, index: indexPath.row)
			
		default:
			specificVC?.project = viewModel.getProject(type: viewModel.projectsWithMe, index: indexPath.row)
		}
		
		self.show(specificVC ?? SpecificProjectViewController(), sender: nil)
	}
}

extension ConfigurationViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: self.view.frame.size.width * 0.9, height: 125)
	}
}
