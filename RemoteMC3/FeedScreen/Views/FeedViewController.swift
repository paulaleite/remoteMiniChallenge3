//
//  FeedViewController.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 11/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class FeedViewController: UIViewController {
    
    var viewModel: FeedViewModel = FeedViewModel()
	
	@IBOutlet var categoryCollectionView: UICollectionView!

	@IBOutlet var projectCollectionView: UICollectionView!
	
	var firstCellState: Int = 0
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationController?.navigationBar.prefersLargeTitles = true
		categoryCollectionView.delegate = self
		categoryCollectionView.dataSource = self
		
		projectCollectionView.dataSource = self
		projectCollectionView.delegate = self
				
		viewModel.delegate = self
        viewModel.loadProjects()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadUI), name: .updateProjects, object: nil)
		    }

    @objc func reloadUI() {
		viewModel.addCategory()
        projectCollectionView.reloadData()
		self.firstCellState = 0
        categoryCollectionView.reloadData()
    }
}

extension FeedViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		switch collectionView {
		case categoryCollectionView:
			return viewModel.getCategoryRowsNumber()
		default:
			return viewModel.getProjectRowsNumber()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		switch collectionView {
		case categoryCollectionView:
			if let feedCategoryCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCategoryCollectionCell", for: indexPath) as? FeedCategoryCollectionCell {
				feedCategoryCollectionCell.categoryImage.image = UIImage(named: viewModel.unselectedImages[indexPath.row])
				feedCategoryCollectionCell.categoryName.text = viewModel.categorys[indexPath.row].name
				feedCategoryCollectionCell.categoryCount.text = String(viewModel.categorys[indexPath.row].count)
				if indexPath.row == 0 {
					if firstCellState == 0 {
						feedCategoryCollectionCell.backgroundColor = .white
						feedCategoryCollectionCell.layer.masksToBounds = false
						feedCategoryCollectionCell.layer.cornerRadius = 37
						feedCategoryCollectionCell.layer.shadowColor = UIColor.black.cgColor
						feedCategoryCollectionCell.layer.shadowOffset = .zero
						feedCategoryCollectionCell.layer.shadowRadius = 4
						feedCategoryCollectionCell.layer.shadowOpacity = 0.3
						feedCategoryCollectionCell.categoryName.textColor = .black
						feedCategoryCollectionCell.categoryCount.layer.cornerRadius = 7
						feedCategoryCollectionCell.categoryCount.layer.borderWidth = 1
						feedCategoryCollectionCell.categoryCount.layer.borderColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
						feedCategoryCollectionCell.categoryImage.image = UIImage(named: viewModel.categorys[indexPath.row].imagem)
						return feedCategoryCollectionCell
					} else {
						if feedCategoryCollectionCell.touched == true {
							feedCategoryCollectionCell.backgroundColor = .white
							feedCategoryCollectionCell.layer.masksToBounds = false
							feedCategoryCollectionCell.layer.cornerRadius = 37
							feedCategoryCollectionCell.layer.shadowColor = UIColor.black.cgColor
							feedCategoryCollectionCell.layer.shadowOffset = .zero
							feedCategoryCollectionCell.layer.shadowRadius = 4
							feedCategoryCollectionCell.layer.shadowOpacity = 0.3
							feedCategoryCollectionCell.categoryName.textColor = .black
							feedCategoryCollectionCell.categoryCount.layer.cornerRadius = 7
							feedCategoryCollectionCell.categoryCount.layer.borderWidth = 1
							feedCategoryCollectionCell.categoryCount.layer.borderColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
							feedCategoryCollectionCell.categoryImage.image = UIImage(named: viewModel.categorys[indexPath.row].imagem)
						} else {
							feedCategoryCollectionCell.backgroundColor = .white
							feedCategoryCollectionCell.layer.masksToBounds = false
							feedCategoryCollectionCell.layer.cornerRadius = 37
							feedCategoryCollectionCell.layer.borderWidth = 1
							feedCategoryCollectionCell.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
							feedCategoryCollectionCell.layer.shadowRadius = 0
							feedCategoryCollectionCell.categoryCount.layer.cornerRadius = 7
							feedCategoryCollectionCell.categoryCount.layer.borderWidth = 1
							feedCategoryCollectionCell.categoryCount.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
						}
							return feedCategoryCollectionCell
					}
				} else {
					if feedCategoryCollectionCell.touched == true {
						feedCategoryCollectionCell.backgroundColor = .white
						feedCategoryCollectionCell.layer.masksToBounds = false
						feedCategoryCollectionCell.layer.cornerRadius = 37
						feedCategoryCollectionCell.layer.shadowColor = UIColor.black.cgColor
						feedCategoryCollectionCell.layer.shadowOffset = .zero
						feedCategoryCollectionCell.layer.shadowRadius = 4
						feedCategoryCollectionCell.layer.shadowOpacity = 0.3
						feedCategoryCollectionCell.categoryName.textColor = .black
						feedCategoryCollectionCell.categoryCount.layer.cornerRadius = 7
						feedCategoryCollectionCell.categoryCount.layer.borderWidth = 1
						feedCategoryCollectionCell.categoryCount.layer.borderColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
						feedCategoryCollectionCell.categoryImage.image = UIImage(named: viewModel.categorys[indexPath.row].imagem)
					} else {
						feedCategoryCollectionCell.categoryName.text = viewModel.categorys[indexPath.row].name
						feedCategoryCollectionCell.categoryCount.text = String(viewModel.categorys[indexPath.row].count)
						feedCategoryCollectionCell.backgroundColor = .white
						feedCategoryCollectionCell.layer.masksToBounds = false
						feedCategoryCollectionCell.layer.cornerRadius = 37
						feedCategoryCollectionCell.layer.borderWidth = 1
						feedCategoryCollectionCell.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
						feedCategoryCollectionCell.layer.shadowRadius = 0
						feedCategoryCollectionCell.categoryCount.layer.cornerRadius = 7
						feedCategoryCollectionCell.categoryCount.layer.borderWidth = 1
						feedCategoryCollectionCell.categoryCount.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
					}
					return feedCategoryCollectionCell
				}
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
                feedProjectCollectionCell.projectResponsible.text = viewModel.projects[indexPath.row].responsible.responsibleName
                feedProjectCollectionCell.projectPhase.text = viewModel.projects[indexPath.row].phases.last
				
				return feedProjectCollectionCell
			}
		}
		
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
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		switch collectionView {
		case categoryCollectionView:
			
			firstCellState = 1
			guard let selectedCell = collectionView.cellForItem(at: indexPath) as? FeedCategoryCollectionCell else {
			 	return }
			
			viewModel.setUpCellsState(collectionView: collectionView)
			selectedCell.touched = true

			switch indexPath.row {
				
			case 1:
				viewModel.select(cell: selectedCell, indexPath: indexPath)
				viewModel.deselect(cells: [
					viewModel.createCell0(collectionView: collectionView),
					viewModel.createCell2(collectionView: collectionView),
					viewModel.createCell3(collectionView: collectionView),
					viewModel.createCell4(collectionView: collectionView)], indexes: [0, 2, 3, 4])
	
			case 2:
				viewModel.select(cell: selectedCell, indexPath: indexPath)
				viewModel.deselect(cells: [
					viewModel.createCell0(collectionView: collectionView),
					viewModel.createCell1(collectionView: collectionView),
					viewModel.createCell3(collectionView: collectionView),
					viewModel.createCell4(collectionView: collectionView)], indexes: [0, 1, 3, 4])

			case 3:
				viewModel.select(cell: selectedCell, indexPath: indexPath)
				viewModel.deselect(cells: [
				viewModel.createCell0(collectionView: collectionView),
				viewModel.createCell1(collectionView: collectionView),
				viewModel.createCell2(collectionView: collectionView),
				viewModel.createCell4(collectionView: collectionView)], indexes: [0, 1, 2, 4])

			case 4:
				viewModel.select(cell: selectedCell, indexPath: indexPath)
				viewModel.deselect(cells: [
				viewModel.createCell0(collectionView: collectionView),
				viewModel.createCell1(collectionView: collectionView),
				viewModel.createCell2(collectionView: collectionView),
				viewModel.createCell3(collectionView: collectionView)], indexes: [0, 1, 2, 3])

			default:
				viewModel.select(cell: selectedCell, indexPath: indexPath)
				viewModel.deselect(cells: [
				viewModel.createCell1(collectionView: collectionView),
				viewModel.createCell2(collectionView: collectionView),
				viewModel.createCell3(collectionView: collectionView),
				viewModel.createCell4(collectionView: collectionView)], indexes: [1, 2, 3, 4])
				
			}
		case projectCollectionView:
			print("Contruir Specific Screen")
			
		default:
			print("Tratar o erro")
		}
	}
}

extension FeedViewController: FeedViewModelDelegate {
    func getProjects(_ completion: @escaping (Result<Response, Error>) -> Void) {
        
    }
}
