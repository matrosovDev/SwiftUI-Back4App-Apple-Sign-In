//
//  ProfileView.swift
//  EasyFitJustTryIt-SwiftUI
//
//  Created by Oleksandr Matrosov on 25/11/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var currentUser: User? = User.current

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("User Info")) {
                    Text("Name: \(getFullName())")
                    Text("Email: \(currentUser?.email ?? "No email provided")")
                }

                Section(header: Text("Actions")) {
                    Button(action: {
                        authViewModel.logout()
                    }) {
                        HStack {
                            Image(systemName: "power")
                                .foregroundColor(.red)
                            Text("Logout")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .onAppear {
                fetchCurrentUser()
            }
        }
    }

    private func getFullName() -> String {
        let firstName = currentUser?.firstName ?? "Unknown"
        let lastName = currentUser?.lastName ?? ""
        return "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
    }
    
    private func fetchCurrentUser() {
        if let current = User.current {
            self.currentUser = current
        } else {
            print("No current user found.")
        }
    }
}
