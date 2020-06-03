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
	
    var selectedSegment = 1
    
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
    
    @IBAction func changeApprovedPending(_ sender: Any) {
        if approvedAndPendingSegmented.selectedSegmentIndex == 0 {
            selectedSegment = 1
        } else {
            selectedSegment = 2
        }
        self.personCollectionView.reloadData()
    }
    
	@objc func denyAction(_ sender: UIButton) {
		
		viewModel?.answerRequisition(answer: false, forUserAt: sender.tag)
        // delete request
        // reload table view
//        self.navigationController?.popToRootViewController(animated: false)
    }
 
    @objc func acceptAction(_ sender: UIButton) {
        viewModel?.answerRequisition(answer: true, forUserAt: sender.tag)
        // delete request
        // reload table view
//        self.navigationController?.popToRootViewController(animated: false)
    }
	
//	@IBAction func saveChanges(_ sender: Any) {
//		//TODO: Salvar todas as mudanças 
//	}
//	
//	@IBAction func cancelChanges(_ sender: Any) {
//		self.dismiss(animated: true, completion: nil)
//	}
	
}

extension PersonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if selectedSegment == 1 {
            guard let numberOfApprovedPeople = viewModel?.getNumberOfUsersApproved() else {
                return -1
            }
            return numberOfApprovedPeople
            
        } else {
            guard let numberOfPendingPeople = viewModel?.getNumberOfPendingPeople() else {
                return -2
            }
            return numberOfPendingPeople
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if selectedSegment == 1 {
            guard let approvedPersonCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "approvedPeopleCell", for: indexPath) as? ApprovedPeopleCollectionCell else {
                    return ApprovedPeopleCollectionCell()
                }
                    
            approvedPersonCollectionCell.backgroundColor = .blue
            approvedPersonCollectionCell.personName.text = viewModel?.getPersonNameApproved(forUserAt: indexPath.row)
            approvedPersonCollectionCell.personEmail.text = viewModel?.getPersonEmailApproved(forUserAt: indexPath.row)
            approvedPersonCollectionCell.personImage.layer.cornerRadius =  35
            approvedPersonCollectionCell.backgroundColor = .white
            approvedPersonCollectionCell.layer.masksToBounds = false
            approvedPersonCollectionCell.layer.cornerRadius = 10
            approvedPersonCollectionCell.layer.shadowColor = UIColor.black.cgColor
            approvedPersonCollectionCell.layer.shadowOffset = .zero
            approvedPersonCollectionCell.layer.shadowRadius = 3
            approvedPersonCollectionCell.layer.shadowOpacity = 0.2
                    
            return approvedPersonCollectionCell
        } else {
            guard let pendingPersonCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "pendingPeopleCell", for: indexPath) as? PendingPeopleCollectionCell else {
                    return ApprovedPeopleCollectionCell()
            }
                    
            pendingPersonCollectionCell.backgroundColor = .blue
            pendingPersonCollectionCell.personName.text = viewModel?.getPendingPeopleName(forUserAt: indexPath.row)
            pendingPersonCollectionCell.personEmail.text = viewModel?.getPendingPeopleEmail(forUserAt: indexPath.row)
            pendingPersonCollectionCell.personImage.layer.cornerRadius =  35
            pendingPersonCollectionCell.backgroundColor = .white
            pendingPersonCollectionCell.layer.masksToBounds = false
            pendingPersonCollectionCell.layer.cornerRadius = 10
            pendingPersonCollectionCell.layer.shadowColor = UIColor.black.cgColor
            pendingPersonCollectionCell.layer.shadowOffset = .zero
            pendingPersonCollectionCell.layer.shadowRadius = 3
            pendingPersonCollectionCell.layer.shadowOpacity = 0.2
			pendingPersonCollectionCell.approvePersonButton.tag = indexPath.row
			pendingPersonCollectionCell.approvePersonButton.addTarget(self, action: #selector(self.acceptAction(_:)), for: .allEvents)
                    
            return pendingPersonCollectionCell
        }
    }
}

extension PersonViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width * 0.9, height: 125)
    }
}
