//
//  ServerService.swift
//  RemoteMC3
//
//  Created by Edgar Sgroi on 18/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation

class ServerService {
    
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
    
    func createNewProject(_ completion: @escaping (Result<Any, Error>) -> Void) {
        
    }
    
}

extension ServerService: FeedViewModelDelegate {
    func getProjects(_ completion: @escaping (Result<Response, Error>) -> Void) {
        URLSession.shared.dataTask(with: .getProjects) { data, _, error in
            if let data = data {
                do {
                    let res = try JSONDecoder().decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(res))
                    }
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
}

extension URL {
    static var getUsers: URL {
        makeForEndpoint("users")
    }
    
    static var getProjects: URL {
        makeForEndpoint("projects")
    }
}

private extension URL {
    static func makeForEndpoint(_ endpoint: String) -> URL {
        return URL(string: "https://projeta-server.herokuapp.com/\(endpoint)")!
    }
}
