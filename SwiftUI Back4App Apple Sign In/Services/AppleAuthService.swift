//
//  AppleAuthService.swift
//  EasyFitJustTryIt-SwiftUI
//
//  Created by Oleksandr Matrosov on 25/11/24.
//

import Foundation
import AuthenticationServices
import ParseSwift

struct UserDetails {
    let userID: String
    let email: String?
    let givenName: String?
    let familyName: String?
}

final class AuthorizationService: NSObject {
    static let shared = AuthorizationService()
    
    func configureAppleRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.email, .fullName]
    }

    func handleAuthorization(result: Result<ASAuthorization, Error>, completion: @escaping (Result<User, Error>) -> Void) {
        switch result {
        case .success(let auth):
            if let appleIDCredential = auth.credential as? ASAuthorizationAppleIDCredential {
                
                let userID = appleIDCredential.user
                let email = appleIDCredential.email
                let fullName = appleIDCredential.fullName
                
                let firstName = fullName?.givenName
                let lastName = fullName?.familyName
                
                guard let identityTokenData = appleIDCredential.identityToken,
                      let identityToken = String(data: identityTokenData, encoding: .utf8) else {
                    completion(.failure(NSError(domain: "AuthorizationService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve Apple credential"])))
                    return
                }
                
                self.loginWithApple(userID: userID, identityToken: identityToken, email: email, firstName: firstName, lastName: lastName, completion: completion)
            } else {
                completion(.failure(NSError(domain: "AuthorizationService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Apple Credential"])))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func loginWithApple(userID: String, identityToken: String, email: String?, firstName: String?, lastName: String?, completion: @escaping (Result<User, Error>) -> Void) {
        
        var authData: [String: String] = [
            "token": identityToken,
            "id": userID
        ]
        if let email = email {
            authData["email"] = email
        }
        if let firstName = firstName, let lastName = lastName {
            authData["username"] = "\(firstName) \(lastName)"
        }

        // Log in with authData
        User.apple.login(authData: authData) { result in
            switch result {
            case .success(var user):
                // Update user fields
                if let email = email {
                    user.email = email // Store email in its own column
                }
                if let firstName = firstName {
                    user.firstName = firstName // Store first name in a custom column
                }
                if let lastName = lastName {
                    user.lastName = lastName // Store last name in a custom column
                }

                // Save updated user
                user.save { saveResult in
                    DispatchQueue.main.async {
                        switch saveResult {
                        case .success(let updatedUser):
                            print("User updated successfully: \(updatedUser)")
                            completion(.success(updatedUser))
                        case .failure(let error):
                            print("Failed to save user: \(error.localizedDescription)")
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                print("Login failed: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
