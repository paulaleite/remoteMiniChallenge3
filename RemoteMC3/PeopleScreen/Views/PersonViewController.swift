//
//  PersonViewController.swift
//  RemoteMC3
//
//  Created by Paula Leite on 02/06/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class PersonViewController: UIViewController {

    var viewModel: PersonViewModel?
    var users: [User]?
    var project: Project?
    
    @IBOutlet weak var approvedAndPendingSegmented: UISegmentedControl!
    @IBOutlet weak var personCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        personCollectionView.delegate = self
        personCollectionView.dataSource = self
        
        guard let project = self.project else {
            return
        }
        self.viewModel = PersonViewModel(project: project)
        self.title = viewModel?.getProjectName()
    }
    
}

extension PersonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberProjects = viewModel?.getNumberOfUsers() else {
            return -1
        }
        
        return numberProjects
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let personCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "aprovedPeopleCell", for: indexPath) as? ApprovedPeopleCollectionCell else {
            return ApprovedPeopleCollectionCell()
        }
        
        personCollectionCell.backgroundColor = .blue
        
//        personCollectionCell.personImage.image = UIImage(named: viewModel.notifications[indexPath.row].personImage)
        personCollectionCell.personName.text = viewModel?.getPersonName(forUserAt: indexPath.row)
        personCollectionCell.personEmail.text = viewModel?.getPersonEmail(forUserAt: indexPath.row)
        personCollectionCell.personImage.layer.cornerRadius =  35
        personCollectionCell.backgroundColor = .white
        personCollectionCell.layer.masksToBounds = false
        personCollectionCell.layer.cornerRadius = 10
        personCollectionCell.layer.shadowColor = UIColor.black.cgColor
        personCollectionCell.layer.shadowOffset = .zero
        personCollectionCell.layer.shadowRadius = 3
        personCollectionCell.layer.shadowOpacity = 0.2
        
        return personCollectionCell
    }
}

extension PersonViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width * 0.9, height: 125)
    }
}
