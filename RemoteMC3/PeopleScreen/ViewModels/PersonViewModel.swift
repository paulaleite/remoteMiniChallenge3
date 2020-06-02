//
//  PersonViewModel.swift
//  RemoteMC3
//
//  Created by Paula Leite on 02/06/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

class PersonViewModel {
    var project: Project?
    var users: [User]?
    let serverService: ServerService = ServerService()

    func getPersonName(forUserAt index: Int) -> String {
        guard let userName = users?[index].name else {
            return "Problem with person's name"
        }
        return userName
    }

    func getPersonEmail(forUserAt index: Int) -> String {
        guard let userEmail = users?[index].email else {
            return "Problem with person's email"
        }
        return userEmail
    }

//    func getPersonImage(forProjectAt index: Int) -> String {
//        return project?.users[index].
//        return notification?.personImage ?? "personalColored"
//    }
    
    func getProjectName() -> String {
        guard let projectName = project?.title else {
            return "Project name not found"
        }
        return projectName
    }
    
    func getNumberOfUsers() -> Int {
        guard let numberOfUsers = users?.count else {
            return -1
        }
        return numberOfUsers
    }
    
    func getUsersInProject() {
        guard let usersID = project?.users else {
            return
        }
        
        serverService.getUsersBy(users: usersID, {(response) in
            switch response {
            case .success(let resp):
                self.users = resp.result
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    init(project: Project) {
        self.project = project
    }
    
//    func answerRequisition(answer: Bool) {
//        guard let notification = notification else { return }
//        serverService.answerRequestParticipation(userID: notification.userRequisitorID, projectID: notification.projectID, answer: answer, {(response) in
//            switch response {
//            case .success(let res):
//                print(res)
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_notifications"), object: nil)
//            case .failure(let error):
//                print(error.localizedDescription)
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_notifications"), object: nil)
//            }
//        })
//    }
}
