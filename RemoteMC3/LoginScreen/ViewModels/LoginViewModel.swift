//
//  LoginViewModel.swift
//  RemoteMC3
//
//  Created by Paula Leite on 25/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import UIKit
import AuthenticationServices

protocol LoginViewControllerDelegate {
    func didFinishAuth()
}

class LoginViewModel {
    
    let serverService = ServerService()
    
    func saveUser(credential: ASAuthorizationAppleIDCredential) {
        serverService.createUser(credential: credential) { (response) in
            switch response {
            case .success(let res):
                print("Usuario cadastrado com sucesso!")
                let userID = res._id
                UserDefaults.standard.set(userID, forKey: "userIDServer")
                
                guard let userIDReturn = UserDefaults.standard.string(forKey: "userIDServer") else {
                    return
                }
                
                print("User ID Server: \(userIDReturn)")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
