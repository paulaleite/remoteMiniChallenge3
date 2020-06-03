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
        getUsersInProject()
    }
}
