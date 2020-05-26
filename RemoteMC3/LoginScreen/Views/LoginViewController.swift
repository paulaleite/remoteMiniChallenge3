//
//  LoginViewController.swift
//  RemoteMC3
//
//  Created by Paula Leite on 18/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel = LoginViewModel()
    
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
        
        viewModel.saveUser(credential: credential)
        
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
        
        //TODO: Pesquisar como fazer nesse caso
//        viewModel.saveUser(credential: credential)
        delegate?.didFinishAuth()
        self.dismiss(animated: true, completion: nil)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userID = appleIDCredential.user
            guard let firstName = appleIDCredential.fullName?.givenName else {
                return
            }
            guard let lastName = appleIDCredential.fullName?.familyName else {
                return
            }
            
            let fullName = firstName + " " + lastName
            UserDefaults.standard.set(userID, forKey: SignInWithAppleManager.userIdentifierKey)
            
            if let _ = appleIDCredential.email, let _ = appleIDCredential.fullName {
                registerNewAccount(credential: appleIDCredential)
            } else {
                UserDefaults.standard.set(userID, forKey: "userIDServer")
                UserDefaults.standard.set(fullName, forKey: "userNameServer")
                UserDefaults.standard.set(appleIDCredential.email, forKey: "userEmailServer")
                signInWithExistingAccount(credential: appleIDCredential)
            }
            
        case let passwordCredential as ASPasswordCredential:
            let userID = passwordCredential.user
            UserDefaults.standard.set(userID, forKey: SignInWithAppleManager.userIdentifierKey)
            
            signInWithUserAndPassword(credential: passwordCredential)
            
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
        let authorizationButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        authorizationButton.cornerRadius = 20
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Bem-vindx ao\nProjeta!"
        label.textColor = UIColor(red: 2/255, green: 14/255, blue: 93/255, alpha: 1)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = .zero
        backgroundView.layer.shadowRadius = 4
        backgroundView.layer.shadowOpacity = 0.3
        backgroundView.layer.cornerRadius = 100
		backgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
		backgroundView.clipsToBounds = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImage = UIImageView()
		iconImage.image = UIImage(named: "icon")
		iconImage.layer.cornerRadius = 150
        iconImage.contentMode = .scaleAspectFill
        iconImage.clipsToBounds = true
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(iconImage)
        view.addSubview(backgroundView)
        backgroundView.addSubview(label)
        backgroundView.addSubview(authorizationButton)
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.45),
			iconImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			iconImage.heightAnchor.constraint(equalToConstant: 300),
            iconImage.widthAnchor.constraint(equalToConstant: 300),
            label.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 40),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            authorizationButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            authorizationButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 75),
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
