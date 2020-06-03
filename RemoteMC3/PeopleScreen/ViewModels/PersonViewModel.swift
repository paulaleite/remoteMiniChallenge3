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
        guard let userEmail = peopleSolicitations?[index].userEmail else {
            return "Problem with pending person's email"
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

    func getPendingUserProject() {
        guard let solicitations = project?.solicitations else {
            return
        }
        
        peopleSolicitations = solicitations
    }
    
    func getInitialsPendingUser(index: Int) -> String {
        guard let userName = peopleSolicitations?[index].userName else {
            return "nil"
        }
        let firstName: String = String(userName.split(separator: " ").first ?? "nil")
        let lastName: String = String(userName.split(separator: " ").last ?? "nil")
        let firstInitial: String = String(Array(firstName).first ?? "n")
        let secondInitial: String = String(Array(lastName).first ?? "i")
        if firstInitial != "nil" {
            return String(firstInitial + secondInitial)
        }
        return String(firstInitial + secondInitial + "l")
    }
    
    func getInitialsApprovedUser(index: Int) -> String {
        guard let userName = users?[index].name else {
            return "nil"}
        let firstName: String = String(userName.split(separator: " ").first ?? "nil")
        let lastName: String = String(userName.split(separator: " ").last ?? "nil")
        let firstInitial: String = String(Array(firstName).first ?? "n")
        let secondInitial: String = String(Array(lastName).first ?? "i")
        if firstInitial != "nil" {
            return String(firstInitial + secondInitial)
        }
        return String(firstInitial + secondInitial + "l")
    }
    
    init(project: Project, users: [User]) {
        self.project = project
        self.users = users
        getPendingUserProject()
    }
    
    func answerRequisition(answer: Bool, forUserAt index: Int) {
        guard let userID = peopleSolicitations?[index].userId else {
            return
        }
        
        guard let projectID = project?._id else {
            return
        }
        
        guard let solicitationID = peopleSolicitations?[index]._id else {
            return
        }
        
        serverService.answerRequestParticipation(userID: userID, projectID: projectID, solicitationID: solicitationID, answer: answer, {(response) in
            switch response {
            case .success(let res):
                print(res)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_notifications"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_notifications"), object: nil)
            }
        })
    }
}
