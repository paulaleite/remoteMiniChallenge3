//
//  FeedViewModel.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 11/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import UIKit

class FeedViewModel {
    let service = ServerService()
	
    var projects: [Project] = []
	
	var categorys: [Category] = []

	var socialProjects = [Project]()
	
	var cultureProjects = [Project]()
	
	var personalProjects = [Project]()
	
	var businessProjects = [Project]()
	
	var researchProjects = [Project]()
	
	var feedProjects = [[Project]]()
	
	var unselectedImages: [String] = ["socialGrey", "cultureGrey", "personalGrey", "businessGrey", "researchGrey"]
	
    var socialCount = 0
	var researchCount = 0
	var personalCount = 0
	var culturalCount = 0
	var entrepreneurialCount = 0
	
	func getProject(forCategoryAt category: Int, forProjectAt index: Int) -> Project {
		return feedProjects[category][index]
	}
	
    func getProjectRowsNumber() -> Int {
        return projects.count
    }
	
	func getCategoryRowsNumber() -> Int {
        return categorys.count
    }
    
	func getProjectTitle(forCategoryAt category: Int, forProjectAt index: Int) -> String {
		return feedProjects[category][index].title
    }
    
    func getProjectResponsible(forCategoryAt category: Int, forProjectAt index: Int) -> String {
		return feedProjects[category][index].responsible.responsibleName
    }
    
    func getProjectPhases(forCategoryAt category: Int, forProjectAt index: Int) -> [String] {
        return feedProjects[category][index].phases
    }
    
    func getProjectCurrentPhase(forCategoryAt category: Int, forProjectAt index: Int) -> String {
        return (feedProjects[category])[index].phases.first ?? "Sem etapas"
    }
	
	func loadProjects() {
        
        service.getProjects({(response) in
            switch response {
            case .success(let res):
                self.projects = res.result
				for project in self.projects {
					if project.category == "Social" {
						self.socialCount += 1
						self.socialProjects.append(project)
					} else if project.category == "Cultural" {
						self.culturalCount += 1
						self.cultureProjects.append(project)
					} else if project.category == "Pessoal" {
						self.personalCount += 1
						self.personalProjects.append(project)
					} else if project.category == "Empresarial" {
						self.entrepreneurialCount += 1
						self.businessProjects.append(project)
					} else if project.category == "Pesquisa" {
						self.researchCount += 1
						self.researchProjects.append(project)
					}
				}
				self.addFeedProjects()
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
		socialProjects.reverse()
		cultureProjects.reverse()
		personalProjects.reverse()
		businessProjects.reverse()
		researchProjects.reverse()
		feedProjects.append(socialProjects)
		feedProjects.append(cultureProjects)
		feedProjects.append(personalProjects)
		feedProjects.append(businessProjects)
		feedProjects.append(researchProjects)
	}
	
}

extension NSNotification.Name {
    static let updateProjects = NSNotification.Name("update_objectives_collection")
	static let category0 = NSNotification.Name("category_0_selected")
	static let category1 = NSNotification.Name("category_1_selected")
	static let category2 = NSNotification.Name("category_2_selected")
	static let category3 = NSNotification.Name("category_3_selected")
	static let category4 = NSNotification.Name("category_4_selected")
}
