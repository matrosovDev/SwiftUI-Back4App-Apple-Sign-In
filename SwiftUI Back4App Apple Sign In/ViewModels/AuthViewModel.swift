//
//  AuthViewModel.swift
//  EasyFitJustTryIt-SwiftUI
//
//  Created by Oleksandr Matrosov on 25/11/24.
//

import Foundation
import ParseSwift
import AuthenticationServices

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String? = nil
    
    private let authService = AuthorizationService.shared
    
    init() {
        checkLoginStatus()
    }
    
    func checkLoginStatus() {
        isLoggedIn = User.current != nil
    }
    
    func logout() {
        User.logout { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isLoggedIn = false
                case .failure(let error):
                    print("Logout error: \(error.localizedDescription)")
                    self.errorMessage = "Logout error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func handleAppleAuthorization(result: Result<ASAuthorization, Error>, completion: @escaping (Bool) -> Void) {
        authService.handleAuthorization(result: result) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Successful login: \(user)")
                    self.isLoggedIn = true
                    completion(true)
                case .failure(let error):
                    print("Login error: \(error.localizedDescription)")
                    self.errorMessage = "Login error: \(error.localizedDescription)"
                    completion(false)
                }
            }
        }
    }
}
