//
//  ParticipantsViewModel.swift
//  RemoteMC3
//
//  Created by Paula Leite on 03/06/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

class ParticipantsViewModel {
    var project: Project?
    var users: [User]?
    let serverService: ServerService = ServerService()
    
    func getPersonNameApproved(forUserAt index: Int) -> String {
        guard let userName = users?[index].name else {
            return "Problem with person's name"
        }
        return userName
    }
    
    func getPersonEmailApproved(forUserAt index: Int) -> String {
        guard let userEmail = users?[index].email else {
            return "Problem with person's email"
        }
        return userEmail
    }
    
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
    
    func getInitials(index: Int) -> String {
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
    }
}
