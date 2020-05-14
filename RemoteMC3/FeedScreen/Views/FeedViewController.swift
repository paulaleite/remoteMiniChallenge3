//
//  FeedViewController.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 11/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    var viewModel: FeedViewModel = FeedViewModel()
	
	@IBOutlet var categoryCollectionView: UICollectionView!

	@IBOutlet var projectCollectionView: UICollectionView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		navigationController?.navigationBar.prefersLargeTitles = true
		
		categoryCollectionView.delegate = self
		categoryCollectionView.dataSource = self
		
		projectCollectionView.dataSource = self
		projectCollectionView.delegate = self
				
    }
	
	override func viewDidAppear(_ animated: Bool) {
		let indexPath: IndexPath = IndexPath(row: 0, section: 0)
		categoryCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
		categoryCollectionView.cellForItem(at: indexPath)?.backgroundColor = .black
	}
	
	func deselect (cellType: FeedCategoryCollectionCell, indexes: [IndexPath]) {
		for celula in indexes {
			categoryCollectionView.deselectItem(at: celula, animated: false)
		}
	}
}

extension FeedViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		switch collectionView {
		case categoryCollectionView:
			viewModel.addCategory()
			return viewModel.getCategoryRowsNumber()
		default:
			viewModel.addProjects()
			return viewModel.getProjectRowsNumber()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		switch collectionView {
		case categoryCollectionView:
			if let feedCategoryCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCategoryCollectionCell", for: indexPath) as? FeedCategoryCollectionCell {
				feedCategoryCollectionCell.backgroundColor = .white
				feedCategoryCollectionCell.layer.masksToBounds = false
				feedCategoryCollectionCell.layer.cornerRadius = 37
				feedCategoryCollectionCell.layer.shadowColor = UIColor.black.cgColor
				feedCategoryCollectionCell.layer.shadowOffset = .zero
				feedCategoryCollectionCell.layer.shadowRadius = 4
				feedCategoryCollectionCell.layer.shadowOpacity = 0.3

				feedCategoryCollectionCell.categoryImage.image = UIImage(named: viewModel.categorys[indexPath.row].imagem)
				feedCategoryCollectionCell.categoryName.text = viewModel.categorys[indexPath.row].name
				feedCategoryCollectionCell.categoryCount.text = String(viewModel.categorys[indexPath.row].count)
				feedCategoryCollectionCell.categoryCount.layer.cornerRadius = 7
				feedCategoryCollectionCell.categoryCount.layer.borderWidth = 1
				feedCategoryCollectionCell.categoryCount.layer.borderColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
				return feedCategoryCollectionCell
			}
			
		default:
			if let feedProjectCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedProjectCollectionCell", for: indexPath) as? FeedProjectCollectionCell {
				feedProjectCollectionCell.backgroundColor = .white
				feedProjectCollectionCell.layer.masksToBounds = false
				feedProjectCollectionCell.layer.cornerRadius = 20
				feedProjectCollectionCell.layer.shadowColor = UIColor.black.cgColor
				feedProjectCollectionCell.layer.shadowOffset = .zero
				feedProjectCollectionCell.layer.shadowRadius = 4
				feedProjectCollectionCell.layer.shadowOpacity = 0.3

				feedProjectCollectionCell.projectName.text = viewModel.projects[indexPath.row].title
				feedProjectCollectionCell.projectResponsible.text = viewModel.projects[indexPath.row].responsible.firstName + " " + viewModel.projects[indexPath.row].responsible.lastName
				feedProjectCollectionCell.projectPhase.text = viewModel.projects[indexPath.row].currentPhase.title
				
				return feedProjectCollectionCell
			}
		}
		
//		MARK: - TODO tratar o erro
		return UICollectionViewCell()
	}
	
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
		switch collectionView {
		case categoryCollectionView:
			return CGSize(width: self.view.frame.size.width * 0.2, height: self.view.frame.size.height * 0.1)
		case projectCollectionView:
			return CGSize(width: self.view.frame.size.width * 0.9, height: 125)
		default:
			return CGSize(width: 0, height: 0)
		}
    }
	
//	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//		switch collectionView {
//		case categoryCollectionView:
//			switch indexPath.row {
//				case 0:
//
//
//				default:
//				<#code#>
//			}
//		default:
//
//		}
//	}
}
