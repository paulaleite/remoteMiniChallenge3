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
		projects.append(Project(title: "Título do projeto", description:
			"Aqui vai haver a descrição do projeto", college: College.FCI,
													   responsible: User(firstName: "Edgar", lastName: "Sgroi"), members: [User(firstName: "Edgar", lastName: "Sgroi")],
													   duration: (Date(timeIntervalSince1970: 2), Date(timeIntervalSince1970: 10)), currentPhase: Phase(title: "Primeira"), phases: [Phase(title: "primeira")], category: "Social"))
	}
	
	func addCategory() {
//		mudar a forma de contar a categoria
		categorys.append(Social(count: 0))
	}
	
	
}
