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
        self.viewModel = ParticipantsViewModel(project: project)
        self.title = viewModel?.getProjectName()
    }
    
}

extension ParticpantsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let numberOfApprovedPeople = viewModel?.getNumberOfUsersApproved() else {
            return -1
        }
        return numberOfApprovedPeople
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let approvedPersonCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "participantsCell", for: indexPath) as? ParticipantsCollectionCell else {
            return ParticipantsCollectionCell()
        }
        
        approvedPersonCollectionCell.backgroundColor = .blue
        approvedPersonCollectionCell.participantName.text = viewModel?.getPersonNameApproved(forUserAt: indexPath.row)
        approvedPersonCollectionCell.participantEmail.text = viewModel?.getPersonEmailApproved(forUserAt: indexPath.row)
        approvedPersonCollectionCell.participantImage.layer.cornerRadius =  35
        approvedPersonCollectionCell.backgroundColor = .white
        approvedPersonCollectionCell.layer.masksToBounds = false
        approvedPersonCollectionCell.layer.cornerRadius = 10
        approvedPersonCollectionCell.layer.shadowColor = UIColor.black.cgColor
        approvedPersonCollectionCell.layer.shadowOffset = .zero
        approvedPersonCollectionCell.layer.shadowRadius = 3
        approvedPersonCollectionCell.layer.shadowOpacity = 0.2
        
        return approvedPersonCollectionCell
    }
}

extension ParticpantsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width * 0.9, height: 125)
    }
}
