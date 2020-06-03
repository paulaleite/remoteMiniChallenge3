//
//  NotificationViewModel.swift
//  RemoteMC3
//
//  Created by Luiza Fattori on 14/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import UIKit

class NotificationViewModel {
    var notifications: [Notification] = []
    var requestsNotification: [RequestNotification] = []
    var serverService: ServerService = ServerService()

    func getNotificationsRowsNumber() -> Int {
        return notifications.count
    }

    func getNotificationRequisitor (forNotificationAt index: Int) -> String {
		return notifications[index].requisitor
    }
	
	func getNotificationProjectRequired (forNotificationAt index: Int) -> String {
		return notifications[index].projectRequired
    }

    func getNotificationPerson (forNotificationAt index: Int) -> String {
        return notifications[index].personImage
    }
	
	func getNotificationProjectID(forNotificationAt index: Int) -> String {
        return notifications[index].projectID
    }
    
    func getNotificationProject(forNotificationAt index: Int, _ completion: @escaping (Project?, [User]?, Error?) -> Void) {
        let projectID = notifications[index].projectID
        
        serverService.getProjectsBy(projects: [projectID]) { (response) in
            switch response {
            case .success(let res):
                if let project = res.result.first {
                    self.serverService.getUsersBy(users: project.users) { (result) in
                        switch result {
                        case .success(let ret):
                            let users = ret.result
                            DispatchQueue.main.async {
                                completion(project, users, nil)
                            }
                        case .failure(let error):
                            print("Didnt find users")
                            DispatchQueue.main.async {
                                completion(project, nil, error)
                            }
                        }
                    }

                } else {
                    print("Error finding number of users")
                }
            case .failure(let error):
                print("Error getting the project index")
                DispatchQueue.main.async {
                    completion(nil, nil, error)
                }
            }
        }
    }
	
    func getInitials(index: Int) -> String {
        let userName = notifications[index].requisitor
        let firstName: String = String(userName.split(separator: " ").first ?? "nil")
        let lastName: String = String(userName.split(separator: " ").last ?? "nil")
        let firstInitial: String = String(Array(firstName).first ?? "n")
        let secondInitial: String = String(Array(lastName).first ?? "i")
        if firstInitial != "nil" {
            return String(firstInitial + secondInitial)
        }
        return String(firstInitial + secondInitial + "l")
    }
    
	func setNotifications () {
		notifications = []
        guard let userID = UserDefaults.standard.string(forKey: "userIDServer") else { return }
        //TODO: Mudar por método que só procura 1 usuário, e não um array
        serverService.getUsersBy(users: [userID], {(result) in
            switch result {
            case .success(let res):
                guard let user = res.result.first else { return }
                guard let projectsIDs = user.projects else { return }
                self.serverService.getProjectsBy(projects: projectsIDs, {(response) in
                    switch response {
                    case .success(let resp):
                        let projects = resp.result
                        for project in projects {
                            for solicitation in project.solicitations {
                                let notification = Notification(personImage: "personalColored", projectRequired: project.title, requisitor: solicitation.userName, requisitorEmail: solicitation.userEmail, projectID: project._id!, userRequisitorID: solicitation.userId, solicitationID: solicitation._id)
                                self.notifications.append(notification)
                            }
                        }
                    case .failure(_):
                        print("Projetos não encontrados")
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_notifications"), object: nil)
                })
            case .failure(_):
                print("Usuario não encontrado.")
            }
        })
	}
}
