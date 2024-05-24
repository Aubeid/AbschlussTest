//
//  RegisterView.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 19.04.24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel: AuthViewModel

    var body: some View {
        ZStack {
//            Color(red: 0.8, green: 0.9, blue: 1.0)
//                .edgesIgnoringSafeArea(.all)

            VStack {
//                Image("logo3")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 500, height: 200)
//                    .padding(.vertical)

                VStack(alignment: .leading) {
                    Text("Email")
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                }

                VStack(alignment: .leading) {
                    Text("Password")
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                }

                VStack(alignment: .leading) {
                    Text("Username")
                    TextField("Username", text: $viewModel.username)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                }

                Button("Register") {
                    viewModel.registerButtonTapped()
                }
                .buttonStyle(.borderedProminent)
                .tint(.black)
                .padding()

                if let user = viewModel.user {
                    Text(user.email ?? "")
                    Text(user.uid)
                }
            }
            .padding()
            .alert(viewModel.errorMessage, isPresented: $viewModel.showAlert, actions: {
                Button(role: .cancel, action: {}, label: {
                    Text("OK")
                })
            })
            .fullScreenCover(isPresented: $viewModel.showMainView) {
                HomeView()
            }
        }
    }
}

#Preview {
    RegisterView(viewModel: AuthViewModel())
}
