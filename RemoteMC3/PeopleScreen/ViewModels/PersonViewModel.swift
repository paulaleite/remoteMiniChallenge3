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
    var peopleSolicitations: [Solicitation]?
    let serverService: ServerService = ServerService()

    func getPersonNameApproved(forUserAt index: Int) -> String {
        guard let userName = users?[index].name else {
            return "Problem with person's name"
        }
        return userName
    }
    
    func getPendingPeopleName(forUserAt index: Int) -> String {
        guard let userName = peopleSolicitations?[index].userName else {
            return "Problem with pending person's name"
        }
        return userName
    }

    func getPersonEmailApproved(forUserAt index: Int) -> String {
        guard let userEmail = users?[index].email else {
            return "Problem with person's email"
        }
        return userEmail
    }
    
    func getPendingPeopleEmail(forUserAt index: Int) -> String {
        guard let userName = users?[index].email else {
            return "Problem with pending person's email"
        }
        return userName
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
    
    func getNumberOfUsersApproved() -> Int {
        guard let numberOfUsers = users?.count else {
            return -1
        }
        return numberOfUsers
    }
    
    func getNumberOfPendingPeople() -> Int {
        guard let numberOfPendingUsers = peopleSolicitations?.count else {
            return -2
        }
        return numberOfPendingUsers
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

    func getPendingUserProject() {
        guard let solicitations = project?.solicitations else {
            return
        }
        
        peopleSolicitations = solicitations
    }
    
    init(project: Project) {
        self.project = project
        getPendingUserProject()
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
