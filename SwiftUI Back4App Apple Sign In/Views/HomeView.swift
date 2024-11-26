//
//  HomeView.swift
//  EasyFitJustTryIt-SwiftUI
//
//  Created by Oleksandr Matrosov on 25/11/24.
//

import SwiftUI

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        NavigationView {
            List {
                Text("Welcome to Home")
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthViewModel())
    }
}
