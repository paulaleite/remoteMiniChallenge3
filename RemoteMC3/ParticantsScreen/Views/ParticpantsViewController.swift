//
//  ParticpantsViewController.swift
//  RemoteMC3
//
//  Created by Paula Leite on 03/06/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import UIKit

class ParticpantsViewController: UIViewController {
    var viewModel: ParticipantsViewModel?
    var users: [User]?
    var project: Project?
    
    @IBOutlet weak var participantsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        participantsCollectionView.delegate = self
        participantsCollectionView.dataSource = self
        
        guard let project = self.project else {
            return
        }
        guard let users = self.users else {
            return
        }
        self.viewModel = ParticipantsViewModel(project: project, users: users)
        self.title = viewModel?.getProjectName()
    }
    
}

extension ParticpantsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let numberOfApprovedPeople = viewModel?.getNumberOfUsersApproved() else {
            return -1
        }
        return numberOfApprovedPeople + 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let approvedPersonCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "participantsCell", for: indexPath) as? ParticipantsCollectionCell else {
            return ParticipantsCollectionCell()
        }
        approvedPersonCollectionCell.backgroundColor = .white
        approvedPersonCollectionCell.layer.masksToBounds = false
        approvedPersonCollectionCell.layer.cornerRadius = 10
        approvedPersonCollectionCell.layer.shadowColor = UIColor.black.cgColor
        approvedPersonCollectionCell.layer.shadowOffset = .zero
        approvedPersonCollectionCell.layer.shadowRadius = 3
        approvedPersonCollectionCell.layer.shadowOpacity = 0.2
		approvedPersonCollectionCell.personImage.layer.cornerRadius =  35
        approvedPersonCollectionCell.personImage.backgroundColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
		if indexPath.row == 0 {
			approvedPersonCollectionCell.participantName.text = viewModel?.getProjectOwnerName()
			approvedPersonCollectionCell.participantEmail.text = viewModel?.getProjectOwnerEmail()
			approvedPersonCollectionCell.personImage.setTitle(viewModel?.getProjectOwnerInitial(), for: .normal)
			
			 return approvedPersonCollectionCell
		} else {
        approvedPersonCollectionCell.participantName.text = viewModel?.getPersonNameApproved(forUserAt: indexPath.row-1)
        approvedPersonCollectionCell.participantEmail.text = viewModel?.getPersonEmailApproved(forUserAt: indexPath.row-1)
        approvedPersonCollectionCell.personImage.setTitle(viewModel?.getInitials(index: indexPath.row-1), for: .normal)
        
        return approvedPersonCollectionCell
		}
		
		return UICollectionViewCell()
    }
}

extension ParticpantsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width * 0.9, height: 125)
    }
}
