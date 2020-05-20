//
//  FeedViewModel.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 11/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

struct Response: Codable {
    let result: [Project]
}

protocol FeedViewModelDelegate: class {
    func getProjects(_ completion: @escaping (Result<Response, Error>) -> Void)
}

class FeedViewModel {
    let service = ServerService()
    var projects: [Project] = []
	
	var categorys: [Category] = []

	var socialProjects: [Project] = []
	
	var cultureProjects: [Project] = []
	
	var personalProjects: [Project] = []
	
	var businessProjects: [Project] = []
	
	var researchProjects: [Project] = []
	
	var feedProjects: [[Project]] = [[]]
	
	var unselectedImages: [String] = ["socialGrey", "cultureGrey", "personalGrey", "businessGrey", "researchGrey"]
	
	weak var delegate: FeedViewModelDelegate?
	
    var socialCount = 0
	var researchCount = 0
	var personalCount = 0
	var culturalCount = 0
	var entrepreneurialCount = 0
	
    func getProjectRowsNumber() -> Int {
        return projects.count
    }
	
	func getCategoryRowsNumber() -> Int {
        return categorys.count
    }
    
    func getProjectTitle(forProjectAt index: Int) -> String {
        return projects[index].title
    }
    
//    func getProjectResponsible(forProjectAt index: Int) -> User {
//        return projects[index].responsible.responsibleName
//    }
    
    func getProjectPhases(forProjectAt index: Int) -> [String] {
        return projects[index].phases
    }
    
//    func getProjectCurrentPhase(forProjectAt index: Int) -> Phase {
//        return projects[index].currentPhase
//    }
	
	func loadProjects() {
//		aqui tem que pegar do servidor
        service.getProjects({(response) in
            switch response {
            case .success(let res):
                self.projects = res.result
				for project in self.projects {
					if project.category == "Social" {
						self.socialCount += 1
						self.socialProjects.append(project)
					} else if project.category == "Cultural" {
						self.culturalCount+=1
						self.cultureProjects.append(project)
					} else if project.category == "Pessoal" {
						self.personalCount+=1
						self.personalProjects.append(project)
					} else if project.category == "Empresarial" {
						self.entrepreneurialCount+=1
						self.businessProjects.append(project)
					} else if project.category == "Pesquisa" {
						self.researchCount+=1
						self.researchProjects.append(project)
					}
				}
                NotificationCenter.default.post(name: .updateProjects, object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
	}
	
	func addCategory() {
		categorys.append(Category(imagem: "socialColored", name: "Social", count: socialCount))
		categorys.append(Category(imagem: "cultureColored", name: "Cultural", count: culturalCount))
		categorys.append(Category(imagem: "personalColored", name: "Pessoal", count: personalCount))
		categorys.append(Category(imagem: "businessColored", name: "Empresarial", count: entrepreneurialCount))
		categorys.append(Category(imagem: "researchColored", name: "Pesquisa", count: researchCount))
	}
	
	func addFeedProjects() {
		feedProjects.append(socialProjects)
		feedProjects.append(cultureProjects)
		feedProjects.append(personalProjects)
		feedProjects.append(personalProjects)
		feedProjects.append(researchProjects)
	}
	
	func deselect (cells: [FeedCategoryCollectionCell], indexes: [Int]) {
		var count: Int = 0
		for cell in cells {
			cell.touched = false
			cell.backgroundColor = .white
			cell.layer.masksToBounds = false
			cell.layer.cornerRadius = 37
			cell.layer.shadowRadius = 0
			cell.layer.borderWidth = 1
			cell.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
			cell.categoryCount.layer.cornerRadius = 7
			cell.categoryCount.layer.borderWidth = 1
			cell.categoryCount.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
			cell.categoryImage.image = UIImage(named: unselectedImages[indexes[count]])
			count+=1
		}
	}
	
	func categoryDeselectConfiguration(cell: FeedCategoryCollectionCell, indexPath: IndexPath) {
		cell.touched = false
		cell.backgroundColor = .white
		cell.layer.masksToBounds = false
		cell.layer.cornerRadius = 37
		cell.layer.shadowRadius = 0
		cell.layer.borderWidth = 1
		cell.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
		cell.categoryCount.layer.cornerRadius = 7
		cell.categoryCount.layer.borderWidth = 1
		cell.categoryCount.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
		cell.categoryImage.image = UIImage(named: unselectedImages[indexPath.row])
	}

	func select (cell: FeedCategoryCollectionCell, indexPath: IndexPath) {
		cell.backgroundColor = .white
		cell.layer.masksToBounds = false
		cell.layer.cornerRadius = 37
		cell.layer.shadowColor = UIColor.black.cgColor
		cell.layer.shadowOffset = .zero
		cell.layer.shadowRadius = 4
		cell.layer.shadowOpacity = 0.3
		cell.categoryImage.image = UIImage(named: categorys[indexPath.row].imagem)
		cell.categoryName.textColor = .black
		cell.categoryCount.layer.cornerRadius = 7
		cell.categoryCount.layer.borderWidth = 1
		cell.categoryCount.layer.borderColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
	}
	
	func categorySelectConfiguration(cell: FeedCategoryCollectionCell, indexPath: IndexPath) {
		cell.backgroundColor = .white
		cell.layer.masksToBounds = false
		cell.layer.cornerRadius = 37
		cell.layer.shadowColor = UIColor.black.cgColor
		cell.layer.shadowOffset = .zero
		cell.layer.shadowRadius = 4
		cell.layer.shadowOpacity = 0.3
		cell.categoryImage.image = UIImage(named: categorys[indexPath.row].imagem)
		cell.categoryName.textColor = .black
		cell.categoryCount.layer.cornerRadius = 7
		cell.categoryCount.layer.borderWidth = 1
		cell.categoryCount.layer.borderColor = #colorLiteral(red: 0.6241586804, green: 0.23033306, blue: 0.2308549583, alpha: 1)
	}
	
	func setUpCellsState(collectionView: UICollectionView) {
		for index in 0...5 {
			guard let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? FeedCategoryCollectionCell else {
			return }
			cell.touched = false
		}
	}
	
//	MARK: - TODO: Handling error
	func createCell0(collectionView: UICollectionView) -> FeedCategoryCollectionCell {
		let index0: IndexPath = IndexPath(row: 0, section: 0)
		
		guard let cell0 = collectionView.cellForItem(at: index0) as? FeedCategoryCollectionCell else {
		return FeedCategoryCollectionCell() }
		
		return cell0
	}
	
	func createCell1(collectionView: UICollectionView) -> FeedCategoryCollectionCell {
		let index1: IndexPath = IndexPath(row: 1, section: 0)
		
		guard let cell1 = collectionView.cellForItem(at: index1) as? FeedCategoryCollectionCell else {
			return FeedCategoryCollectionCell() }
		
		return cell1
	}
	
	func createCell2(collectionView: UICollectionView) -> FeedCategoryCollectionCell {
		let index2: IndexPath = IndexPath(row: 2, section: 0)

		guard let cell2 = collectionView.cellForItem(at: index2) as? FeedCategoryCollectionCell else {
		return FeedCategoryCollectionCell() }
		
		return cell2
	}
	
	func createCell3(collectionView: UICollectionView) -> FeedCategoryCollectionCell {
		let index3: IndexPath = IndexPath(row: 3, section: 0)

		guard let cell3 = collectionView.cellForItem(at: index3) as? FeedCategoryCollectionCell else {
		return FeedCategoryCollectionCell() }

		return cell3
	}
	
	func createCell4(collectionView: UICollectionView) -> FeedCategoryCollectionCell {
		let index4: IndexPath = IndexPath(row: 4, section: 0)

		guard let cell4 = collectionView.cellForItem(at: index4) as? FeedCategoryCollectionCell else {
		return FeedCategoryCollectionCell() }
		
		return cell4
	}

}

extension NSNotification.Name {
    static let updateProjects = NSNotification.Name("update_objectives_collection")
}
