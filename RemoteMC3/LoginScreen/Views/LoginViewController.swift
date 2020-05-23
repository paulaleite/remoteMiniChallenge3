//
//  LoginViewController.swift
//  RemoteMC3
//
//  Created by Paula Leite on 18/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import UIKit
import AuthenticationServices

protocol LoginViewControllerDelegate {
    func didFinishAuth()
}

class LoginViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSignInWithAppleButton()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    // Implementacao no Servidor -> POST
    private func registerNewAccount(credential: ASAuthorizationAppleIDCredential) {
        print("Registering new account with user: \(credential.user)")
        guard let fullName = credential.fullName else {
            return
        }
        guard let email = credential.email else {
            return
        }
        
        let userInfo = ["name": "\(fullName)", "email": "\(email)"]
        
        if let url = URL(string: "https://projeta-server.herokuapp.com/createUser") {
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)
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
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
                }).resume()
        }
        
        delegate?.didFinishAuth()
        self.dismiss(animated: true, completion: nil)
    }
    
    // Implementacao no Servidor -> GET
    private func signInWithExistingAccount(credential: ASAuthorizationAppleIDCredential) {
        print("Signing in with existing account with user: \(credential.user)")
        delegate?.didFinishAuth()
        self.dismiss(animated: true, completion: nil)
    }
    
    // Implementacao no Servidor
    private func signInWithUserAndPassword(credential: ASPasswordCredential) {
        print("Signing in using an existing iCloud Keychain credential with user: \(credential.user)")
        delegate?.didFinishAuth()
        self.dismiss(animated: true, completion: nil)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userID = appleIDCredential.user
            UserDefaults.standard.set(userID, forKey: SignInWithAppleManager.userIdentifierKey)
            
            if let _ = appleIDCredential.email, let _ = appleIDCredential.fullName {
                registerNewAccount(credential: appleIDCredential)
            } else {
                signInWithExistingAccount(credential: appleIDCredential)
            }
            
            break
            
        case let passwordCredential as ASPasswordCredential:
            let userID = passwordCredential.user
            UserDefaults.standard.set(userID, forKey: SignInWithAppleManager.userIdentifierKey)
            
            signInWithUserAndPassword(credential: passwordCredential)
            
            break
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setUpSignInWithAppleButton() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(authorizationButton)
        NSLayoutConstraint.activate([
            authorizationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            authorizationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorizationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            authorizationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        authorizationButton.addTarget(self, action: #selector(handleAppleIDRequest), for: .touchUpInside)
    }
    
    @objc func handleAppleIDRequest() {
        // This mecanism generates the requisition to authenticate the user based on their Apple ID.
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        // The controller that takes care of the request
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
