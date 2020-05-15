//
//  ConfigurationViewController.swift
//  RemoteMC3
//
//  Created by Luiza Fattori on 15/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class ConfigurationViewController: UIViewController {
    var viewModel: ConfigurationViewModel = ConfigurationViewModel()

    @IBOutlet weak var projectsCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        projectsCollectionView.delegate = self
        projectsCollectionView.dataSource = self
    }
}

extension ConfigurationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getProjectsRowsNumber()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let configurationCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "configurationCell", for: indexPath) as? ConfigurationCollectionCell else {
            return ConfigurationCollectionCell()
        }

        configurationCollectionCell.nameProject.text = viewModel.projects[indexPath.row].title
        configurationCollectionCell.responsableProject.text = viewModel.projects[indexPath.row].responsable
        configurationCollectionCell.phaseProject.text = viewModel.projects[indexPath.row].phase

        configurationCollectionCell.backgroundColor = .white
        configurationCollectionCell.layer.cornerRadius = 20
        configurationCollectionCell.layer.shadowColor = UIColor.black.cgColor
        configurationCollectionCell.layer.shadowOffset = .zero
        configurationCollectionCell.layer.shadowRadius = 4
        configurationCollectionCell.layer.shadowOpacity = 0.3

        return configurationCollectionCell
    }
}

extension ConfigurationViewController: UICollectionViewDelegate {
    
}
