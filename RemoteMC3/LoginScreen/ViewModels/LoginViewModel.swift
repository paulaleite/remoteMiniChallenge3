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
    
    func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: KeychainInfo.service, account: KeychainInfo.account).saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
    
    func authenticateUser(userID: String, _ completion: @escaping () -> Void) {
        serverService.authenticate(appleID: userID) { (response) in
            switch response {
            case .success(let user):
                let userID = user._id
                let userName = user.name
                let userEmail = user.email
                UserDefaults.standard.set(userID, forKey: "userIDServer")
                UserDefaults.standard.set(userName, forKey: "userNameServer")
                UserDefaults.standard.set(userEmail, forKey: "userEmailServer")
                
                guard let userIDReturn = UserDefaults.standard.string(forKey: "userIDServer") else {
                    return
                }
                guard let userNameReturn = UserDefaults.standard.string(forKey: "userNameServer") else {
                    return
                }
                guard let userEmailReturn = UserDefaults.standard.string(forKey: "userEmailServer") else {
                    return
                }
                completion()
            case .failure(let error):
                print("Error Authenticate")
                print(error.localizedDescription)
            }
        }
    }
    
    func saveUser(credential: ASAuthorizationAppleIDCredential) {
        serverService.createUser(credential: credential) { (response) in
            switch response {
            case .success(let res):
                print("Usuario cadastrado com sucesso!")
                let userID = res._id
                let userName = res.name
                let userEmail = res.email
                UserDefaults.standard.set(userID, forKey: "userIDServer")
                UserDefaults.standard.set(userName, forKey: "userNameServer")
                UserDefaults.standard.set(userEmail, forKey: "userEmailServer")
                
                guard let userIDReturn = UserDefaults.standard.string(forKey: "userIDServer") else {
                    return
                }
                guard let userNameReturn = UserDefaults.standard.string(forKey: "userNameServer") else {
                    return
                }
                guard let userEmailReturn = UserDefaults.standard.string(forKey: "userEmailServer") else {
                    return
                }
                
                print("User ID Server: \(userIDReturn)")
                print("User Name Server: \(userNameReturn)")
                print("User Email Server: \(userEmailReturn)")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
