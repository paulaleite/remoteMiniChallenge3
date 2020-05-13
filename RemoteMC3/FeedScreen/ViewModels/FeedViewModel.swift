//
//  FeedViewModel.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 11/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

protocol FeedViewModelDelegate: class {
    func fetchData(_ completion: @escaping (Result<Any, Error>) -> Void)
}

class FeedViewModel {
    var projects: [Project] = []
	
	var categorys: [Category] = []
	
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
			"Aqui vai haver a descrição do projeto", college: College.FCI,
													   responsible: User(firstName: "Carroselina", lastName: "Sgroi"),
													   members: [User(firstName: "Edgar", lastName: "Sgroi")],
													   duration: (Date(timeIntervalSince1970: 2), Date(timeIntervalSince1970: 10)),
													   currentPhase: Phase(title: "Primeira"), phases: [Phase(title: "primeira")], category: "Social"))
		projects.append(Project(title: "Projeto", description:
		"Aqui vai haver a descrição do projeto", college: College.FCI,
												   responsible: User(firstName: "Carroselina", lastName: "Sgroi"),
												   members: [User(firstName: "Edgar", lastName: "Sgroi")],
												   duration: (Date(timeIntervalSince1970: 2), Date(timeIntervalSince1970: 10)),
												   currentPhase: Phase(title: "Primeira"), phases: [Phase(title: "primeira")], category: "Social"))
		projects.append(Project(title: "Projeto", description:
		"Aqui vai haver a descrição do projeto", college: College.FCI,
												   responsible: User(firstName: "Carroselina", lastName: "Sgroi"),
												   members: [User(firstName: "Edgar", lastName: "Sgroi")],
												   duration: (Date(timeIntervalSince1970: 2), Date(timeIntervalSince1970: 10)),
												   currentPhase: Phase(title: "Primeira"), phases: [Phase(title: "primeira")], category: "Social"))
		projects.append(Project(title: "Projeto", description:
		"Aqui vai haver a descrição do projeto", college: College.FCI,
												   responsible: User(firstName: "Carroselina", lastName: "Sgroi"),
												   members: [User(firstName: "Edgar", lastName: "Sgroi")],
												   duration: (Date(timeIntervalSince1970: 2), Date(timeIntervalSince1970: 10)),
												   currentPhase: Phase(title: "Primeira"), phases: [Phase(title: "primeira")], category: "Social"))
		projects.append(Project(title: "Projeto", description:
		"Aqui vai haver a descrição do projeto", college: College.FCI,
												   responsible: User(firstName: "Carroselina", lastName: "Sgroi"),
												   members: [User(firstName: "Edgar", lastName: "Sgroi")],
												   duration: (Date(timeIntervalSince1970: 2), Date(timeIntervalSince1970: 10)),
												   currentPhase: Phase(title: "Primeira"), phases: [Phase(title: "primeira")], category: "Social"))
		projects.append(Project(title: "Projeto", description:
		"Aqui vai haver a descrição do projeto", college: College.FCI,
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
		categorys.append(Category(imagem: "Group 19", name: "Social", count: socialCount))
		categorys.append(Category(imagem: "Group 19", name: "Cultural", count: culturalCount))
		categorys.append(Category(imagem: "Group 19", name: "Pessoal", count: personalCount))
		categorys.append(Category(imagem: "Group 19", name: "Empresarial", count: entrepreneurialCount))
		categorys.append(Category(imagem: "Group 19", name: "Pesquisa", count: researchCount))

	}

}
