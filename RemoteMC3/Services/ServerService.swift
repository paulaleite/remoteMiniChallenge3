//
//  ServerService.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 18/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

class ServerService: CommunicationProtocol {
    
    func getProjects(_ completion: @escaping (Result<Response, Error>) -> Void) {
        URLSession.shared.dataTask(with: .getProjects) { data, _, error in
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(Response.self, from: data)
                    print(res.result)
                    DispatchQueue.main.async {
                        completion(.success(res))
                    }
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
    
    func getUsers(_ completion: @escaping (Result<User, Error>) -> Void) {
        URLSession.shared.dataTask(with: .getUsers) { data, _, error in
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(User.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(res))
                    }
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
    
    func createProject(project: Project, _ completion: @escaping (Result<Any, Error>) -> Void) {
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

        session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
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
    
    func getUsersBy(users ids: [String], _ completion: @escaping (Result<User, Error>) -> Void) {
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
    
    static var createProject: URL {
        makeForEndpoint("createProject")
    }
}

private extension URL {
    static private func makeForEndpoint(_ endpoint: String) -> URL {
        return URL(string: "https://projeta-server.herokuapp.com/\(endpoint)")!
    }
}
