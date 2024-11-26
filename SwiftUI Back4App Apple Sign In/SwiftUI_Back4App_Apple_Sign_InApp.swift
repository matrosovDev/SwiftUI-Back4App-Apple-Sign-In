//
//  SwiftUI_Back4App_Apple_Sign_InApp.swift
//  SwiftUI Back4App Apple Sign In
//
//  Created by Oleksandr Matrosov on 26/11/24.
//

import SwiftUI
import ParseSwift

@main
struct SwiftUI_Back4App_Apple_Sign_InApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    
    init() {
        ParseSwift.initialize(applicationId: "your_applicationId",
                              clientKey: "your_clientKey",
                              serverURL: URL(string: "https://parseapi.back4app.com/")!)
    }
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isLoggedIn {
                MainTabView()
                    .environmentObject(authViewModel)
            } else {
                LoginView()
                    .environmentObject(authViewModel)
            }
        }
    }
}


