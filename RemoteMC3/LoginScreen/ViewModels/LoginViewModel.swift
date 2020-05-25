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
            case .success(_):
                print("Usuario cadastrado com sucesso!")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
