//
//  FeedViewModel.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 11/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

protocol FeedViewModelDelegate: class {
    func fetchData(_ completion: @escaping (Result<Any, Error>) -> Void)
	
}

class FeedViewModel {
    var projects: [Project] = []
	
	var categorys: [Category] = []

	var unselectedImages: [String] = ["a", "b", "c", "d", "e"]
	
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
    
    func getProjectResponsible(forProjectAt index: Int) -> User {
        return projects[index].responsible
    }
    
    func getProjectPhases(forProjectAt index: Int) -> [Phase] {
        return projects[index].phases
    }
    
    func getProjectCurrentPhase(forProjectAt index: Int) -> Phase {
        return projects[index].currentPhase
    }
	
	func addProjects() {
//		aqui tem que pegar do servidor
		projects.append(Project(title: "Projeto", description:
			"Aqui vai haver a descrição do projeto", college: College(name: "Mackenzie"),
													   responsible: User(firstName: "Carroselina", lastName: "Sgroi"),
													   members: [User(firstName: "Edgar", lastName: "Sgroi")],
													   duration: (Date(timeIntervalSince1970: 2), Date(timeIntervalSince1970: 10)),
													   currentPhase: Phase(title: "Primeira"), phases: [Phase(title: "primeira")], category: "Social"))
		projects.append(Project(title: "Projeto", description:
		"Aqui vai haver a descrição do projeto", college: College(name: "Mackenzie"),
												   responsible: User(firstName: "Carroselina", lastName: "Sgroi"),
												   members: [User(firstName: "Edgar", lastName: "Sgroi")],
												   duration: (Date(timeIntervalSince1970: 2), Date(timeIntervalSince1970: 10)),
												   currentPhase: Phase(title: "Primeira"), phases: [Phase(title: "primeira")], category: "Social"))
		projects.append(Project(title: "Projeto", description:
		"Aqui vai haver a descrição do projeto", college: College(name: "Mackenzie"),
												   responsible: User(firstName: "Carroselina", lastName: "Sgroi"),
												   members: [User(firstName: "Edgar", lastName: "Sgroi")],
												   duration: (Date(timeIntervalSince1970: 2), Date(timeIntervalSince1970: 10)),
												   currentPhase: Phase(title: "Primeira"), phases: [Phase(title: "primeira")], category: "Social"))
		projects.append(Project(title: "Projeto", description:
		"Aqui vai haver a descrição do projeto", college: College(name: "Mackenzie"),
												   responsible: User(firstName: "Carroselina", lastName: "Sgroi"),
												   members: [User(firstName: "Edgar", lastName: "Sgroi")],
												   duration: (Date(timeIntervalSince1970: 2), Date(timeIntervalSince1970: 10)),
												   currentPhase: Phase(title: "Primeira"), phases: [Phase(title: "primeira")], category: "Social"))
		projects.append(Project(title: "Projeto", description:
		"Aqui vai haver a descrição do projeto", college: College(name: "Mackenzie"),
												   responsible: User(firstName: "Carroselina", lastName: "Sgroi"),
												   members: [User(firstName: "Edgar", lastName: "Sgroi")],
												   duration: (Date(timeIntervalSince1970: 2), Date(timeIntervalSince1970: 10)),
												   currentPhase: Phase(title: "Primeira"), phases: [Phase(title: "primeira")], category: "Social"))
		projects.append(Project(title: "Projeto", description:
		"Aqui vai haver a descrição do projeto", college: College(name: "Mackenzie")
			,
												   responsible: User(firstName: "Carroselina", lastName: "Sgroi"),
												   members: [User(firstName: "Edgar", lastName: "Sgroi")],
												   duration: (Date(timeIntervalSince1970: 2), Date(timeIntervalSince1970: 10)),
												   currentPhase: Phase(title: "Primeira"), phases: [Phase(title: "primeira")], category: "Social"))

		for project in projects {
			if (project.category == "Social") {
				socialCount+=1
			}else if (project.category == "Cultural") {
				culturalCount+=1
			}else if (project.category == "Pessoal") {
				personalCount+=1
			}else if (project.category == "Empresarial") {
				entrepreneurialCount+=1
			}else if (project.category == "Pesquisa") {
				researchCount+=1
			}
		}
	}
	
	func addCategory() {
		categorys.append(Category(imagem: "socialColored", name: "Social", count: socialCount))
		categorys.append(Category(imagem: "cultureGrey", name: "Cultural", count: culturalCount))
		categorys.append(Category(imagem: "personalGrey", name: "Pessoal", count: personalCount))
		categorys.append(Category(imagem: "businessGrey", name: "Empresarial", count: entrepreneurialCount))
		categorys.append(Category(imagem: "Group 19", name: "Pesquisa", count: researchCount))

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
