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
    var users: [User]?
	var myOwn: Bool?
	var isParticipating: Bool?
	@IBOutlet var projectDescryption: UITextView!
	@IBOutlet var projectResponsible: UILabel!
	@IBOutlet var projectStart: UILabel!
	@IBOutlet var projectEnd: UILabel!
	@IBOutlet var projectInstitution: UILabel!
	@IBOutlet var usersCollectionView: UICollectionView!
	@IBOutlet var phasesTableView: UITableView!
	@IBOutlet var projectCategory: UILabel!
	var participationButton: UIBarButtonItem?

	override func viewDidLoad() {
		super.viewDidLoad()
		
        self.viewModel = SpecificProjectViewModel(project: project!)
        
		usersCollectionView.delegate = self
		usersCollectionView.dataSource = self
		
		phasesTableView.dataSource = self
        
        myOwn = viewModel?.checkProjectOwner()
        isParticipating = viewModel?.checkProjectParticipation()
		
		if myOwn == true {
			navigationController?.navigationBar.prefersLargeTitles = true
			participationButton = UIBarButtonItem(title: "Editar", style: .done, target: self, action: #selector(self.askPermission))
			navigationItem.setRightBarButton(participationButton, animated: true)
			navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0.0525861159, blue: 0.3849625885, alpha: 1)
		} else {
			if isParticipating == true {
				navigationController?.navigationBar.prefersLargeTitles = true
				participationButton = UIBarButtonItem(title: "Sair", style: .done, target: self, action: #selector(self.askPermission))
				navigationItem.setRightBarButton(participationButton, animated: true)
				navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0.0525861159, blue: 0.3849625885, alpha: 1)
			} else {
				navigationController?.navigationBar.prefersLargeTitles = true
				participationButton = UIBarButtonItem(title: "Participar", style: .done, target: self, action: #selector(self.askPermission))
				navigationItem.setRightBarButton(participationButton, animated: true)
				navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0.0525861159, blue: 0.3849625885, alpha: 1)
			}
		}
        self.title = viewModel?.getProject().title
        NotificationCenter.default.addObserver(self, selector: #selector(reloadUsersCollection), name: NSNotification.Name("update_users"), object: nil)
		
		setInformation()
	}
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.setUsers()
        
    }
    
    @objc func reloadUsersCollection() {
        usersCollectionView.reloadData()
    }
	
	@objc func askPermission() {
		if myOwn == true {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let specificVC = storyboard.instantiateViewController(withIdentifier: "EditProjectViewController") as? EditProjectViewController
			specificVC?.project = self.project
			self.show(specificVC ?? EditProjectViewController(), sender: nil)
		} else {
			if isParticipating == true {
				let alert = UIAlertController(title: "Sair do Projeto", message: "Você tem certeza de que deseja sair desse projeto?", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { _ in }))
				alert.addAction(UIAlertAction(title: "Sair", style: .destructive, handler: { (_) in
					//TODO: Aqui deve sair do servidor como membro
					self.viewModel?.exitProject()
				}))
				self.present(alert, animated: true, completion: nil)
			} else {
				let alert = UIAlertController(title: "Solicitar Participação", message: "Você tem certeza de que deseja participar desse projeto?", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { _ in }))
				alert.addAction(UIAlertAction(title: "Participar", style: .cancel, handler: { (_) in
					self.viewModel?.requireParticipation()
				}))
				self.present(alert, animated: true, completion: nil)
			}
		}
	}
	
	func setInformation() {
		projectDescryption.text = viewModel?.getProjectDescription()
		projectResponsible.text = viewModel?.getResponsible()
		projectInstitution.text = viewModel?.getProjectOrganization()
		projectStart.text = viewModel?.getStart()
		projectEnd.text = viewModel?.getEnd()
		projectCategory.text = viewModel?.getProjectCategory()
//		remove top space of grouped table view
		var frame = CGRect.zero
		frame.size.height = .leastNormalMagnitude
		phasesTableView.tableHeaderView = UIView(frame: frame)		
	}
	
	@IBAction func seeMoreAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if myOwn == true {
            let specificVC = storyboard.instantiateViewController(withIdentifier: "PersonViewController") as? PersonViewController

            specificVC?.project = self.project
            specificVC?.users = viewModel?.users
            self.show(specificVC ?? PersonViewController(), sender: nil)
        } else {
            let participantsVC = storyboard.instantiateViewController(withIdentifier: "ParticpantsViewController") as? ParticpantsViewController
            participantsVC?.project = self.project
            participantsVC?.users = viewModel?.users
            self.show(participantsVC ?? ParticpantsViewController(), sender: nil)
        }
		
	}
}

extension SpecificProjectViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if indexPath.row != 4 {
			return CGSize(width: 60, height: 60)
		} else {
			return CGSize(width: 40, height: 40)
		}
	}
}

extension SpecificProjectViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if (((viewModel?.getNumberOfUsers())! + 1) <= 4) {
			return ((viewModel?.getNumberOfUsers())! + 1)
		} else {
			return 5
		}
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if indexPath.row  == 4 {
			if let specificProjectCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecificProjectCollectionCell", for: indexPath) as? SpecificProjectCollectionCell {
				specificProjectCollectionCell.person.layer.cornerRadius = 20
				specificProjectCollectionCell.person.backgroundColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
				specificProjectCollectionCell.person.setTitle(String((viewModel?.getNumberOfUsers())! - 4) + "+", for: .normal)
				return  specificProjectCollectionCell
			}
		} else {
			if let specificProjectCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecificProjectCollectionCell", for: indexPath) as? SpecificProjectCollectionCell {
				specificProjectCollectionCell.person.layer.cornerRadius = 30
				specificProjectCollectionCell.person.backgroundColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
				specificProjectCollectionCell.person.setTitle(viewModel?.getInitials(index: indexPath.row), for: .normal)
				return  specificProjectCollectionCell
			}
		}
		return UICollectionViewCell()
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
			specificProjectTableCell.phaseDescription.text = viewModel?.getPhase(index: indexPath.section)
			specificProjectTableCell.phaseDescription.layer.cornerRadius = 5
			specificProjectTableCell.phaseDescription.layer.borderWidth = 0.5
			
			if indexPath.section == 0 {
				specificProjectTableCell.phaseDescription.layer.borderColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
				specificProjectTableCell.dot.image = UIImage(named: "coloredDot")
			return specificProjectTableCell
			} else {
				specificProjectTableCell.dot.image = UIImage(named: "grayDot")
				specificProjectTableCell.phaseDescription.layer.borderColor = #colorLiteral(red: 0.5097514391, green: 0.5098407865, blue: 0.509739697, alpha: 1)
				return specificProjectTableCell
			}
		}
		return UITableViewCell()
	}
}

extension SpecificProjectViewController: SpecificProjectViewModelDelegate {
	func addSucessAlert() {
		let alert = UIAlertController(title: "Solicitação enviada", message: "Sua solicitação para participar desse Projeto foi enviada com sucesso.", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
			
		}))
		self.present(alert, animated: true, completion: nil)
	}
	
	func addErrorAlert() {
		let alert = UIAlertController(title: "Erro ao enviar solicitação",
									  message: "Não foi possível enviar sua solicitacão para participar dese Projeto nesse momento. Por favor, tente outra vez.", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
		}))
		self.present(alert, animated: true, completion: nil)
	}
}
