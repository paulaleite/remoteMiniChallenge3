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
            let req: [String: Any] = [
                "userId": project.responsible.responsibleId,
                "project": [
                    "title": project.title,
                    "organization": project.organization != nil ? project.organization!  : "",
                    "description": project.description,
                    "start": project.start,
                    "end": project.end,
                    "category": project.category,
                    "phases": project.phases,
                    "responsible": [
                        "responsibleId": project.responsible.responsibleId,
                        "responsibleName": project.responsible.responsibleName
                    ]
                ]
            ]
//            let req = Requisition(userId: project.responsible.responsibleId, project: project)
//            let jsonData = try JSONEncoder().encode(req)
//            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
//               print(JSONString)
//            }
//            request.httpBody = jsonData
            request.httpBody = try JSONSerialization.data(withJSONObject: req, options: .prettyPrinted)
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
                DispatchQueue.main.async {
                    completion(.success(true))
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
        
        let appleId = credential.user
        
        let fullName = firstName + " " + lastName
        
        let userInfo = ["name": "\(fullName)", "email": "\(email)", "appleId": "\(appleId)"]
        
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
    
    internal func getProjectsBy(projects ids: [String],_ completion: @escaping (Result<ResponseProjects, Error>) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: .getProjectsByIDs)
        request.httpMethod = "POST"
        
        do {
            let req = ["projectsID": ids]
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
    
    internal func requireParticipation(projectID: String, userID: String, userName: String, userEmail: String, _ completion: @escaping (Result<Any, Error>) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: .requireParticipation)
        request.httpMethod = "POST"
        
        do {
            let req = ["projectID": projectID, "solicitation": ["userId": userID, "userName": userName, "userEmail": userEmail, "status": false]] as [String: Any]
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
    
    internal func answerRequestParticipation(userID: String, projectID: String, solicitationID: String, answer: Bool, _ completion: @escaping (Result<Any, Error>) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: .answerRequestParticipation)
        request.httpMethod = "POST"
        
        do {
            let req: [String: Any] = ["userID": userID, "projectID": projectID, "solicitationID": solicitationID, "answer": answer]
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
    
    func deleteProject(projectID: String, _ completion: @escaping (Result<Any, Error>) -> Void) {
        guard let url = URL(string: "https://projeta-server.herokuapp.com/deleteProject/" + projectID) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(Bool.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(res))
                    }
                } catch let error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func removeUserFromProject(projectID: String, userID: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: .removeUserFromProject)
        request.httpMethod = "POST"
        
        do {
            let req = ["projectID": projectID, "userID": userID] as [String : Any]
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
                    let res = try JSONDecoder().decode(String.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(res))
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }).resume()
    }
    
    func updateProject(project: Project, _ completion: @escaping (Result<String, Error>) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: .updateProject)
        request.httpMethod = "POST"
        
        do {
            guard let projectID = project._id else { return }
            let req: [String: Any] = ["projectID": projectID,
                       "title": project.title,
                       "organization": project.organization ?? "",
                       "description": project.description,
                       "start": project.start,
                       "end": project.end,
                       "category": project.category,
                       "phases": project.phases]
            request.httpBody = try JSONSerialization.data(withJSONObject: req, options: .prettyPrinted)
            if let json = try JSONSerialization.jsonObject(with: request.httpBody!, options: .mutableContainers) as? [String: Any] {
                print(json)
            }
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
            if let data = data {
                do {
                //create json object from data
                    
//                    let res = try JSONDecoder().decode(String.self, from: data)
                    DispatchQueue.main.async {
//                        completion(.success(res))
                        completion(.success("Foi"))
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }).resume()
    }
    
    func authenticate(appleID: String, _ completion: @escaping (Result<User, Error>) -> Void) {
            let session = URLSession.shared
            var request = URLRequest(url: .authenticate)
            request.httpMethod = "POST"
            
            do {
                let req = ["appleId": appleID]
                request.httpBody = try JSONSerialization.data(withJSONObject: req, options: .prettyPrinted)
                if let json = try JSONSerialization.jsonObject(with: request.httpBody!, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
                if let data = data {
                    do {
                    //create json object from data
                        
                        let res = try JSONDecoder().decode(User.self, from: data)
                        DispatchQueue.main.async {
    //                        completion(.success(res))
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
    
    static var deleteProject: URL {
        makeForEndpoint("deleteProject/")
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
    
    static var removeUserFromProject: URL {
        makeForEndpoint("removeUserFromProject")
    }
    
    static var updateProject: URL {
        makeForEndpoint("updateProject")
    }
    
    static var authenticate: URL {
        makeForEndpoint("authenticate")
    }
}

private extension URL {
    static private func makeForEndpoint(_ endpoint: String) -> URL {
        return URL(string: "https://projeta-server.herokuapp.com/\(endpoint)")!
    }
}
