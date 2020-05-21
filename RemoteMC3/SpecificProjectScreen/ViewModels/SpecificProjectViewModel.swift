//
//  SpecificProjectViewModel.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 15/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

protocol SpecificProjectDelegate: class {
    func getUsersBy(users ids: [String], _ completion: @escaping (Result<User, Error>) -> Void)
}

class SpecificProjectViewModel {
	
//    var projsect = Project(title: "Projeto Teste", description: "Teste", category: "Social", start: "10-20-2020", end: "20-20-2020", phases: ["Aaaa"], responsible:
//        User(name: "Edgar", email: "edgar_email@email.com", projects: nil), users:
//        [User(name: "Edgar", email: "edgar_email@email.com", projects: nil)])
    
    var project = Project(phases: ["Aaaa"], users: ["Edgar"], title: "Projeto Teste",
                          description: "Teste", start: "10-20-2020", end: "20-20-2020",
                          category: "Social", responsible: Responsible(responsibleId: "adfadfads", responsibleName: "Edgar"))
    
//	var project = Project(title: "Projeto", description:
//	"Aqui vai haver a descrição do projetoLorem ipsum dolor sit amet, consectetur adipiscing elit,sed Aqui vai haver a descrição do projetoLorem elit,sed", college: College(name: "Mackenzie"),
//											   responsible: User(firstName: "Carroselina", lastName: "Sgroi"),
//											   members: [User(firstName: "Edgar", lastName: "Sgroikkkkkkkkkk"), User(firstName: "Edgar", lastName: "Sgroi"),
//														 User(firstName: "Edgar", lastName: "Sgroi"), User(firstName: "Edgar", lastName: "Sgroi"), User(firstName: "Edgar", lastName: "Sgroi"), User(firstName: "Edgar", lastName: "Sgroi")],
//											   duration: (Date(), Date()),
//											   currentPhase: Phase(title: "Primeira"),
//											   phases: [Phase(title: "Pesquisa sobre como fazer o design Pesquisa sobre como fazer o design Pesquisa sobre como fazer o design Pesquisa sobre como fazer o design "),
//														Phase(title: "bbbbb"),
//														Phase(title: "aaaaaaaa")],
//											   category: "Social", image: "cas")
	
	func getProject() -> Project {
		return project
	}
}
