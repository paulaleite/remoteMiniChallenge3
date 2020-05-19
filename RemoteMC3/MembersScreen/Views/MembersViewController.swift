//
//  MembersViewController.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 19/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class MembersViewController: UIViewController {
	
	var viewModel = MembersViewModel()
	@IBOutlet var membersCollectionView: UICollectionView!
	
override func viewDidLoad() {
        super.viewDidLoad()

        membersCollectionView.dataSource = self
		membersCollectionView.delegate = self
		
		viewModel.setProjects()
    }
}

extension MembersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.getMembersRowsNumber()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let membersCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "membersCollectionCell", for: indexPath) as? MembersCollectionCell else {
            return MembersCollectionCell()
        }

		membersCollectionCell.memberEmail.text = viewModel.getMemberEmail(index: indexPath.row)
		membersCollectionCell.memberName.text = viewModel.getMemberName(index: indexPath.row)
		membersCollectionCell.memberImage.image = UIImage(named: viewModel.getMemberImage(index: indexPath.row))
		
		membersCollectionCell.memberImage.layer.cornerRadius = 35
		membersCollectionCell.layer.masksToBounds = false
        membersCollectionCell.backgroundColor = .white
        membersCollectionCell.layer.cornerRadius = 20
        membersCollectionCell.layer.shadowColor = UIColor.black.cgColor
        membersCollectionCell.layer.shadowOffset = .zero
        membersCollectionCell.layer.shadowRadius = 4
        membersCollectionCell.layer.shadowOpacity = 0.3

        return membersCollectionCell
    }
}

extension MembersViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: self.view.frame.size.width * 0.9, height: 125)
	}
}
