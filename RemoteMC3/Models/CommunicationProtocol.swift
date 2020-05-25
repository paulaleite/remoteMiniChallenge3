//
//  CommunicationProtocol.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 21/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import AuthenticationServices

protocol CommunicationProtocol: class {
    func getProjects(_ completion: @escaping (Result<ResponseProjects, Error>) -> Void)
    
    func getUsersBy(users ids: [String], _ completion: @escaping (Result<ResponseUsers, Error>) -> Void)
    
    func createProject(project: Project, _ completion: @escaping (Result<Any, Error>) -> Void)
    
    func createUser(credential: ASAuthorizationAppleIDCredential, _ completion: @escaping (Result<User, Error>) -> Void)
}
