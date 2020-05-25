//
//  CommunicationProtocol.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 21/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

protocol CommunicationProtocol: class {
    func getProjects(_ completion: @escaping (Result<ResponseProjects, Error>) -> Void)
    
    func getUsersBy(users ids: [String], _ completion: @escaping (Result<ResponseUsers, Error>) -> Void)
    
    func getProjectsBy(projects ids: [String], _ completion: @escaping (Result<ResponseProjects, Error>) -> Void)
    
    func createProject(project: Project, _ completion: @escaping (Result<Any, Error>) -> Void)
    
    func requireParticipation(userID: String, projectID: String, _ completion: @escaping (Result<Any, Error>) -> Void)
    
    func answerRequestParticipation(userID: String, projectID: String, answer: Bool, _ completion: @escaping (Result<Any, Error>) -> Void)
}
