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
	
	@IBOutlet var viewLabel: UILabel!
	
	var categorySelected = 0
	
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
		NotificationCenter.default.addObserver(self, selector: #selector(reloadProjectCollectionView0), name: .category0, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(reloadProjectCollectionView1), name: .category1, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(reloadProjectCollectionView2), name: .category2, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(reloadProjectCollectionView3), name: .category3, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(reloadProjectCollectionView4), name: .category4, object: nil)

	}

    @objc func reloadUI() {
		viewModel.addCategory()
        projectCollectionView.reloadData()
		self.firstCellState = 0
        categoryCollectionView.reloadData()
		
		if viewModel.socialCount == 0 {
			viewLabel.text = "Não há projetos cadastrados para essa categoria."
			} else {
			self.viewLabel.isHidden = true
		}
    }
	
	@objc func reloadProjectCollectionView0() {
		if viewModel.socialCount != 0 {
			self.viewLabel.isHidden = true
			for row in 0...viewModel.socialProjects.count {
				guard let cell = projectCollectionView.cellForItem(at: IndexPath(row: row, section: 0)) as? FeedProjectCollectionCell else {
					return }
				cell.projectName.text = viewModel.getProjectTitle(forCategoryAt: 0, forProjectAt: row)
				cell.projectPhase.text = viewModel.getProjectCurrentPhase(forCategoryAt: 0, forProjectAt: row)
				cell.projectResponsible.text = viewModel.getProjectResponsible(forCategoryAt: 0, forProjectAt: row)
			}
			
		}
		viewLabel.text = "Não há projetos cadastrados para essa categoria."
		self.viewLabel.isHidden = false
	}
	
	@objc func reloadProjectCollectionView1() {
		if viewModel.culturalCount != 0 {
			self.viewLabel.isHidden = true
			for row in 0...viewModel.cultureProjects.count {
				guard let cell = projectCollectionView.cellForItem(at: IndexPath(row: row, section: 0)) as? FeedProjectCollectionCell else {
					return }
				cell.projectName.text = viewModel.getProjectTitle(forCategoryAt: 1, forProjectAt: row)
				cell.projectPhase.text = viewModel.getProjectCurrentPhase(forCategoryAt: 1, forProjectAt: row)
				cell.projectResponsible.text = viewModel.getProjectResponsible(forCategoryAt: 1, forProjectAt: row)
			}
		}
		viewLabel.text = "Não há projetos cadastrados para essa categoria."
		self.viewLabel.isHidden = false
	}
	
	@objc func reloadProjectCollectionView2() {
		if viewModel.personalCount != 0 {
			self.viewLabel.isHidden = true
			for row in 0...viewModel.personalProjects.count {
				guard let cell = projectCollectionView.cellForItem(at: IndexPath(row: row, section: 0)) as? FeedProjectCollectionCell else {
					return }
				cell.projectName.text = viewModel.getProjectTitle(forCategoryAt: 2, forProjectAt: row)
				cell.projectPhase.text = viewModel.getProjectCurrentPhase(forCategoryAt: 2, forProjectAt: row)
				cell.projectResponsible.text = viewModel.getProjectResponsible(forCategoryAt: 2, forProjectAt: row)
			}
		}
		viewLabel.text = "Não há projetos cadastrados para essa categoria."
		viewLabel.isHidden = false
	}
	
	@objc func reloadProjectCollectionView3() {
		if viewModel.entrepreneurialCount !=  0 {
			self.viewLabel.isHidden = true
			for row in 0...viewModel.businessProjects.count {
				guard let cell = projectCollectionView.cellForItem(at: IndexPath(row: row, section: 0)) as? FeedProjectCollectionCell else {
					return }
				cell.projectName.text = viewModel.getProjectTitle(forCategoryAt: 3, forProjectAt: row)
				cell.projectPhase.text = viewModel.getProjectCurrentPhase(forCategoryAt: 3, forProjectAt: row)
				cell.projectResponsible.text = viewModel.getProjectResponsible(forCategoryAt: 3, forProjectAt: row)
			}
		}
		viewLabel.text = "Não há projetos cadastrados para essa categoria."
		viewLabel.isHidden = false
	}
	
	@objc func reloadProjectCollectionView4() {
		if viewModel.researchCount != 0 {
			self.viewLabel.isHidden = true
			for row in 0...viewModel.researchProjects.count {
				guard let cell = projectCollectionView.cellForItem(at: IndexPath(row: row, section: 0)) as? FeedProjectCollectionCell else {
					return }
				cell.projectName.text = viewModel.getProjectTitle(forCategoryAt: 4, forProjectAt: row)
				cell.projectPhase.text = viewModel.getProjectCurrentPhase(forCategoryAt: 4, forProjectAt: row)
				cell.projectResponsible.text = viewModel.getProjectResponsible(forCategoryAt: 4, forProjectAt: row)
			}
		}
		viewLabel.text = "Não há projetos cadastrados para essa categoria."
		viewLabel.isHidden = false
	}
}

extension FeedViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		switch collectionView {
		case categoryCollectionView:
			return viewModel.getCategoryRowsNumber()
		default:
			if self.categorySelected == 0 && viewModel.socialCount != 0 {
				return viewModel.socialCount
			} else if categorySelected == 1 && viewModel.culturalCount != 0 {
				return viewModel.culturalCount
			} else if categorySelected == 2 && viewModel.personalCount != 0 {
				return viewModel.personalCount
			} else if categorySelected == 3 && viewModel.entrepreneurialCount != 0 {
				return viewModel.entrepreneurialCount
			} else if categorySelected == 4 && viewModel.researchCount != 0 {
				return viewModel.researchCount
			}
		}
		return 0
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
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
						NotificationCenter.default.post(name: .category0, object: nil)
						viewModel.categorySelectConfiguration(cell: feedCategoryCollectionCell, indexPath: indexPath)
						return feedCategoryCollectionCell
					} else {
						if feedCategoryCollectionCell.touched == true {
							viewModel.categorySelectConfiguration(cell: feedCategoryCollectionCell, indexPath: indexPath)
						} else {
							viewModel.categoryDeselectConfiguration(cell: feedCategoryCollectionCell, indexPath: indexPath)
						}
							return feedCategoryCollectionCell
					}
				} else {
					if feedCategoryCollectionCell.touched == true {
						viewModel.categorySelectConfiguration(cell: feedCategoryCollectionCell, indexPath: indexPath)
					} else {
						viewModel.categoryDeselectConfiguration(cell: feedCategoryCollectionCell, indexPath: indexPath)
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
				self.categorySelected = 1 
				NotificationCenter.default.post(name: .category1, object: nil)
				projectCollectionView.reloadData()
	
			case 2:
				viewModel.select(cell: selectedCell, indexPath: indexPath)
				viewModel.deselect(cells: [
					viewModel.createCell0(collectionView: collectionView),
					viewModel.createCell1(collectionView: collectionView),
					viewModel.createCell3(collectionView: collectionView),
					viewModel.createCell4(collectionView: collectionView)], indexes: [0, 1, 3, 4])
				self.categorySelected = 2
				NotificationCenter.default.post(name: .category2, object: nil)
				projectCollectionView.reloadData()

			case 3:
				viewModel.select(cell: selectedCell, indexPath: indexPath)
				viewModel.deselect(cells: [
				viewModel.createCell0(collectionView: collectionView),
				viewModel.createCell1(collectionView: collectionView),
				viewModel.createCell2(collectionView: collectionView),
				viewModel.createCell4(collectionView: collectionView)], indexes: [0, 1, 2, 4])
				self.categorySelected = 3
				NotificationCenter.default.post(name: .category3, object: nil)
				projectCollectionView.reloadData()

			case 4:
				viewModel.select(cell: selectedCell, indexPath: indexPath)
				viewModel.deselect(cells: [
				viewModel.createCell0(collectionView: collectionView),
				viewModel.createCell1(collectionView: collectionView),
				viewModel.createCell2(collectionView: collectionView),
				viewModel.createCell3(collectionView: collectionView)], indexes: [0, 1, 2, 3])
				self.categorySelected = 4
				NotificationCenter.default.post(name: .category4, object: nil)
				projectCollectionView.reloadData()

			default:
				viewModel.select(cell: selectedCell, indexPath: indexPath)
				viewModel.deselect(cells: [
				viewModel.createCell1(collectionView: collectionView),
				viewModel.createCell2(collectionView: collectionView),
				viewModel.createCell3(collectionView: collectionView),
				viewModel.createCell4(collectionView: collectionView)], indexes: [1, 2, 3, 4])
				self.categorySelected = 0
				NotificationCenter.default.post(name: .category0, object: nil)
				projectCollectionView.reloadData()
				
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
