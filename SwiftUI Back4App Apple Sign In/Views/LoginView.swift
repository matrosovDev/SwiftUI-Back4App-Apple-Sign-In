//
//  LoginView.swift
//  EasyFitJustTryIt-SwiftUI
//
//  Created by Oleksandr Matrosov on 25/11/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            SignInWithAppleButton(
                .signIn,
                onRequest: { request in
                    request.requestedScopes = [.email, .fullName]
                },
                onCompletion: { result in
                    authViewModel.handleAppleAuthorization(result: result) { success in
                        if success {
                            print("Successful navigation to HomeView")
                        }
                    }
                }
            )
            .frame(width: 280, height: 45)
            .signInWithAppleButtonStyle(.black)

            if let errorMessage = authViewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
