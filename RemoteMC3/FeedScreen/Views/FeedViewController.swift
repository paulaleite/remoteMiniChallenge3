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
		
		categoryCollectionView.register(FeedCategoryCollectionCell.self, forCellWithReuseIdentifier: "FeedCategoryCollectionCell")
		projectCollectionView.register(FeedProjectCollectionCell.self, forCellWithReuseIdentifier: "FeedProjectCollectionCell")
		
		categoryCollectionView.delegate = self
		categoryCollectionView.dataSource = self
		
		projectCollectionView.dataSource = self
		projectCollectionView.delegate = self
				
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
				feedCategoryCollectionCell.backgroundColor = .black
//				feedCategoryCollectionCell.categoryName.text = "öi"
////				feedCategoryCollectionCell.categoryImage.image = UIImage(named: viewModel.categorys[indexPath.row].imagem)
////				feedCategoryCollectionCell.categoryName.text = viewModel.categorys[indexPath.row].name
//				feedCategoryCollectionCell.categoryCount.text = String(viewModel.categorys.count)
				return feedCategoryCollectionCell
			}
			
		default:
			if let feedProjectCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedProjectCollectionCell", for: indexPath) as? FeedProjectCollectionCell {
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
			return CGSize(width: self.view.frame.size.width * 0.9, height: self.view.frame.size.height * 0.725)
		default:
			return CGSize(width: self.view.frame.size.width * 0.3, height: self.view.frame.size.height * 0.1)
		}
		
    }
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
	}
}
