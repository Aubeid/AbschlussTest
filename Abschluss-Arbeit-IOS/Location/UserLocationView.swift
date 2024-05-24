//
//  UserLocationView.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 11.05.24.
//

//import SwiftUI
//import MapKit
//
//struct UserLocationView: View {
//    let user: User
//    @StateObject private var viewModel = HomeViewModel()
//
//    init(user: User) {
//        self.user = user
//    }
//
//    var body: some View {
//        VStack {
//            if let userLocation = user.location {
//                MapView(coordinate: userLocation.coordinate)
//                    .frame(height: 300)
//            } else {
//                Text("Standort wird geladen...")
//            }
//
//            Text("Standort von \(user.username)")
//                .font(.headline)
//        }
//        .padding()
//    }
//}
//
//
//
//#Preview {
//    UserLocationView(user: User(id: "String", email: "String", username: "Hallo", createdAt: "12.12.12", photoURL: "", location: nil))
//}
