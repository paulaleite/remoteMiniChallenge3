//
//  SignInWithAppleManager.swift
//  RemoteMC3
//
//  Created by Paula Leite on 22/05/20.
//  Copyright © 2020 Paula Leite. All rights reserved.
//

import Foundation
import AuthenticationServices

struct SignInWithAppleManager {
    static let userIdentifierKey = "userIdentifier"
    
    static func checkUserAuth(completion: @escaping (AuthState) -> ()) {
        guard let userIdentifier = UserDefaults.standard.string(forKey: userIdentifierKey) else {
            print("User identifier does not exist")
            completion(.undefined)
            return
        }
        
        if userIdentifier == "" {
            print("User identifier is empty string")
            completion(.undefined)
            return
        }
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
            DispatchQueue.main.async {
                switch credentialState {
                case .authorized:
                    print("Credential state: .authorized")
                    completion(.signedIn)
                    break
                case .revoked:
                    print("Credential state: .revoked")
                    completion(.undefined)
                    break
                case .notFound:
                    print("Credential state: .notFound")
                    completion(.signedOut)
                    break
                default:
                    break
                }
            }
        }
    }
}
