//
//  NotificationViewController.swift
//  RemoteMC3
//
//  Created by Luiza Fattori on 14/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import UIKit
import NotificationCenter
import UserNotifications

class NotificationViewController: UIViewController {
	
    var viewModel: NotificationViewModel = NotificationViewModel()

    @IBOutlet weak var notificationCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
		
        navigationController?.navigationBar.prefersLargeTitles = true

        notificationCollectionView.delegate = self
        notificationCollectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadUI), name: NSNotification.Name("reload_notifications"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.setNotifications()
    }
    
    @objc func reloadUI() {
        notificationCollectionView.reloadData()
    }
    
}

extension NotificationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNotificationsRowsNumber()
    }

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let notificationCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "notificationCell", for: indexPath) as? NotificationCollectionCell else {
			return NotificationCollectionCell()
		}
		
		notificationCollectionCell.backgroundColor = .red
		
		notificationCollectionCell.notificationMessage.text = viewModel.notifications[indexPath.row].requisitor
			+ " desejar participar do projeto " + viewModel.notifications[indexPath.row].projectRequired
        notificationCollectionCell.personImage.layer.cornerRadius =  35
        notificationCollectionCell.personImage.backgroundColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
        notificationCollectionCell.personImage.setTitle(viewModel.getInitials(index: indexPath.row), for: .normal)
		notificationCollectionCell.backgroundColor = .white
		notificationCollectionCell.layer.masksToBounds = false
		notificationCollectionCell.layer.cornerRadius = 10
		notificationCollectionCell.layer.shadowColor = UIColor.black.cgColor
		notificationCollectionCell.layer.shadowOffset = .zero
		notificationCollectionCell.layer.shadowRadius = 4
		notificationCollectionCell.layer.shadowOpacity = 0.3
		
		return notificationCollectionCell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		
//		let memberVC = storyboard.instantiateViewController(withIdentifier: "MemberViewController") as? MemberViewController
		
//		memberVC?.notification = viewModel.getNotification(forNotificationAt: indexPath.row)
		
//		self.show(memberVC ?? MemberViewController(), sender: nil)
        
        let personVC = storyboard.instantiateViewController(withIdentifier: "PersonViewController") as? PersonViewController
        viewModel.getNotificationProject(forNotificationAt: indexPath.row, {(project, users, error) in
            if error != nil {
                print("Didn't find project and/or user")
            } else {
                personVC?.project = project
                personVC?.users = users
                self.show(personVC ?? PersonViewController(), sender: nil)
            }
            
        })
        
        
	}
}

extension NotificationViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: self.view.frame.size.width * 0.9, height: 125)
	}
}
