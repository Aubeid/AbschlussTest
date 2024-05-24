//
//  UserListView.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 10.05.24.
//

//
//import SwiftUI
//import MapKit
//import Firebase
//import Abschluss_Arbeit_IOS/Location/MapViewW// Importieren Sie die separate Datei


//struct UserListView: View {
//    @StateObject private var viewModel = HomeViewModel()
//    @State private var selectedUser: User?
//
//    var body: some View {
//        NavigationView {
//            List(viewModel.users) { user in
//                Button(action: {
//                    selectedUser = user
//                }) {
//                    Text(user.username)
//                }
//            }
//            .navigationBarTitle("Benutzer")
//            .sheet(item: $selectedUser) { user in
//                UserLocationView(user: user)
//            }
//            .onAppear {
//                viewModel.fetchUsers()
//            }
//        }
//    }
//}
//
//
//#Preview {
//    UserListView()
//}
