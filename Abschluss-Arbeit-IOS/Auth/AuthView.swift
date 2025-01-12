//
//  AuthView.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 19.04.24.
//

import SwiftUI

struct AuthView: View {
    
    @StateObject private var viewModel: AuthViewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack{
                ZStack{
                    //                Image("logo2")
                    //                    .resizable()
                    //                    .scaledToFill()
                    //                    .edgesIgnoringSafeArea(.all)
                    //                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //                    .opacity(0.5)
                    //            Color(red: 0.8, green: 0.9, blue: 1.0)
                    //                .edgesIgnoringSafeArea(.all)
                    VStack {
                        Image("logo3")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 500, height: 200)
                            .padding(.vertical)
                        
                        VStack(alignment:.leading){
                            Text("Email")
                            TextField("Email", text: $viewModel.email)
                                .textFieldStyle(.roundedBorder)
                                .textInputAutocapitalization(.never)
                        }
                        
                        VStack(alignment:.leading){
                            Text("Password")
                            SecureField("Password", text: $viewModel.password)
                                .textFieldStyle(.roundedBorder)
                                .textInputAutocapitalization(.never)
                        }
                        
                        Button("Login") {
                            viewModel.loginButtonTapped()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.black)
                        .padding()
                        
                        if !viewModel.showMainView {
                            NavigationLink(destination: RegisterView(viewModel: viewModel)) {
                                Text("Not registered? Register here")
                                    .underline()
                                    .foregroundColor(.blue)
                            }
                        }
                        
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
                    .onAppear {
                        viewModel.checkLoggedIn()
                    }
                    .fullScreenCover(isPresented: $viewModel.showMainView) {
                        HomeView()
                    }
                }
            }        
        }
    }
}

#Preview {
    AuthView()
}
