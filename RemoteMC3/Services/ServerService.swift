//
//  ServerService.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 18/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import AuthenticationServices

class ServerService: CommunicationProtocol {
    
    internal func getProjects(_ completion: @escaping (Result<ResponseProjects, Error>) -> Void) {
        URLSession.shared.dataTask(with: .getProjects) { data, _, error in
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(ResponseProjects.self, from: data)
//                    print(res.result)
                    DispatchQueue.main.async {
                        completion(.success(res))
                    }
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
    
    internal func getUsers(_ completion: @escaping (Result<User, Error>) -> Void) {
        URLSession.shared.dataTask(with: .getUsers) { data, _, error in
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(User.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(res))
                    }
                } catch let error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    internal func createProject(project: Project, _ completion: @escaping (Result<Any, Error>) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: .createProject)
        request.httpMethod = "POST"

        do {
            let req = Requisition(userId: project.responsible.responsibleId, project: project)
            let jsonData = try JSONEncoder().encode(req)
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
               print(JSONString)
            }
            request.httpBody = jsonData
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }).resume()
    }
    
    func createUser(credential: ASAuthorizationAppleIDCredential, _ completion: @escaping (Result<User, Error>) -> Void) {
        guard let firstName = credential.fullName?.givenName else {
            return
        }
        guard let lastName = credential.fullName?.familyName else {
            return
        }
        guard let email = credential.email else {
            return
        }
        
        let fullName = firstName + " " + lastName
        
        let userInfo = ["name": "\(fullName)", "email": "\(email)"]
        
        let session = URLSession.shared
        var request = URLRequest(url: .createUser)
        request.httpMethod = "POST"
                
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)
        } catch let error {
                print(error.localizedDescription)
        }
                
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
                
        session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(User.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(res))
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }).resume()
    }
  
    internal func getUsersBy(users ids: [String], _ completion: @escaping (Result<ResponseUsers, Error>) -> Void) {

        let session = URLSession.shared
        var request = URLRequest(url: .getUsersByIDs)
        request.httpMethod = "POST"
        
        do {
            let req = ["users": ids]
            request.httpBody = try JSONSerialization.data(withJSONObject: req, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
            if let data = data {
                do {
                //create json object from data
//                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                    print(json)
                    let res = try JSONDecoder().decode(ResponseUsers.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(res))
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }).resume()
    }
    //TODO: Testar
    internal func getProjectsBy(projects ids: [String], _ completion: @escaping (Result<ResponseProjects, Error>) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: .getProjectsByIDs)
        request.httpMethod = "POST"
        
        do {
            let req = ["projects": ids]
            request.httpBody = try JSONSerialization.data(withJSONObject: req, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
            if let data = data {
                do {
                //create json object from data
//                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                    print(json)
                    let res = try JSONDecoder().decode(ResponseProjects.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(res))
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }).resume()
    }
    //TODO: Testar
    internal func requireParticipation(userID: String, projectID: String, _ completion: @escaping (Result<Any, Error>) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: .requireParticipation)
        request.httpMethod = "POST"
        
        do {
            let req = ["userID": userID, "projectID": projectID]
            request.httpBody = try JSONSerialization.data(withJSONObject: req, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
            if let data = data {
                do {
                //create json object from data
//                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                    print(json)
//                    let res = try JSONDecoder().decode(Any, from: data)
//                    DispatchQueue.main.async {
//                        completion(.success(res))
//                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }).resume()
    }
    
    //TODO: Testar
    internal func answerRequestParticipation(userID: String, projectID: String, answer: Bool, _ completion: @escaping (Result<Any, Error>) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: .answerRequestParticipation)
        request.httpMethod = "POST"
        
        do {
            let req = ["userID": userID, "projectID": projectID, "answer": answer] as [String : Any]
            request.httpBody = try JSONSerialization.data(withJSONObject: req, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
            if let data = data {
                do {
                //create json object from data
//                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                    print(json)
                    let res = try JSONDecoder().decode(Bool.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(res))
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }).resume()
    }
}

extension URL {
    static var getUsers: URL {
        makeForEndpoint("users")
    }
    
    static var getProjects: URL {
        makeForEndpoint("projects")
    }
    
    static var getUsersByIDs: URL {
        makeForEndpoint("users/ids")
    }
    
    static var getProjectsByIDs: URL {
        makeForEndpoint("getProjectsByIds")
    }
    
    static var createProject: URL {
        makeForEndpoint("createProject")
    }
    
    static var createUser: URL {
        makeForEndpoint("createUser")
    }
  
    static var requireParticipation: URL {
        makeForEndpoint("requireParticipation")
    }
    
    static var answerRequestParticipation: URL {
        makeForEndpoint("answerRequestParticipation")
    }
}

private extension URL {
    static private func makeForEndpoint(_ endpoint: String) -> URL {
        return URL(string: "https://projeta-server.herokuapp.com/\(endpoint)")!
    }
}
