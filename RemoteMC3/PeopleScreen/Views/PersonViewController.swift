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
        guard let users = self.users else {
            return
        }
        self.viewModel = PersonViewModel(project: project, users: users)
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
        let alert = UIAlertController(title: "Recusar Integrante", message: "Você tem certeza de que deseja recusar a participação no projeto?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "Confirmar", style: .cancel, handler: { (_) in
            self.viewModel?.answerRequisition(answer: false, forUserAt: sender.tag)
        }))
        self.present(alert, animated: true, completion: nil)
        // reload table view
    }
 
    @objc func acceptAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Aprovar Integrante", message: "Você tem certeza de que deseja aprovar a participação no projeto?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "Aprovar", style: .cancel, handler: { (_) in
            self.viewModel?.answerRequisition(answer: true, forUserAt: sender.tag)
        }))
        self.present(alert, animated: true, completion: nil)
        // reload table view
    }
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
            approvedPersonCollectionCell.personImage.backgroundColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
            approvedPersonCollectionCell.personImage.setTitle(viewModel?.getInitialsApprovedUser(index: indexPath.row), for: .normal)
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
            pendingPersonCollectionCell.personImage.backgroundColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
            pendingPersonCollectionCell.personImage.setTitle(viewModel?.getInitialsPendingUser(index: indexPath.row), for: .normal)
            pendingPersonCollectionCell.backgroundColor = .white
            pendingPersonCollectionCell.layer.masksToBounds = false
            pendingPersonCollectionCell.layer.cornerRadius = 10
            pendingPersonCollectionCell.layer.shadowColor = UIColor.black.cgColor
            pendingPersonCollectionCell.layer.shadowOffset = .zero
            pendingPersonCollectionCell.layer.shadowRadius = 3
            pendingPersonCollectionCell.layer.shadowOpacity = 0.2
			pendingPersonCollectionCell.approvePersonButton.tag = indexPath.row
			pendingPersonCollectionCell.approvePersonButton.addTarget(self, action: #selector(self.acceptAction(_:)), for: .allEvents)
            pendingPersonCollectionCell.unapprovePersonButton.tag = indexPath.row
            pendingPersonCollectionCell.unapprovePersonButton.addTarget(self, action: #selector(self.denyAction(_:)), for: .allEvents)
                    
            return pendingPersonCollectionCell
        }
    }
}

extension PersonViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width * 0.9, height: 125)
    }
}

extension PersonViewController: PersonViewModelDelegate {
    func addSucessAlert() {
        let alert = UIAlertController(title: "Resposta enviada", message: "Sua resposta foi enviada com sucesso.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addErrorAlert() {
        let alert = UIAlertController(title: "Erro ao enviar resposta",
                                      message: "Não foi possível enviar a sua resposta. Por favor, tente outra vez.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
