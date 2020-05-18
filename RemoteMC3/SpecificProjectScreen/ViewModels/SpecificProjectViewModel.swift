//
//  SpecificProjectViewModel.swift
//  RemoteMC3
//
//  Created by Cassia Aparecida Barbosa on 15/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class SpecificProjectViewModel {
	
	var project = Project(title: "Projeto", description:
	"Aqui vai haver a descrição do projetoLorem ipsum dolor sit amet, consectetur adipiscing elit,sed Aqui vai haver a descrição do projetoLorem elit,sed", college: College(name: "Mackenzie"),
											   responsible: User(firstName: "Carroselina", lastName: "Sgroi"),
											   members: [User(firstName: "Edgar", lastName: "Sgroikkkkkkkkkk"), User(firstName: "Edgar", lastName: "Sgroi"),
														 User(firstName: "Edgar", lastName: "Sgroi"), User(firstName: "Edgar", lastName: "Sgroi"), User(firstName: "Edgar", lastName: "Sgroi"), User(firstName: "Edgar", lastName: "Sgroi")],
											   duration: (Date(), Date()),
											   currentPhase: Phase(title: "Primeira"),
											   phases: [Phase(title: "Pesquisa sobre como fazer o design Pesquisa sobre como fazer o design Pesquisa sobre como fazer o design Pesquisa sobre como fazer o design "),
														Phase(title: "bbbbb"),
														Phase(title: "aaaaaaaa")],
											   category: "Social", image: "cas")
	
	func getProject() -> Project {
		return project
	}
}
