//
//  AuthViewModel.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 19.04.24.
//

import Foundation
import FirebaseAuth

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password  = ""
    @Published var username = ""
    
    @Published var user: FirebaseAuth.User?
    
    @Published var showAlert = false
    @Published var errorMessage = ""
    
    @Published var showMainView = false
    @Published var isRegistered = false
    //@Published var showAuthView = false
    
    init() {
       checkLoggedIn()
    }
    
    
    func checkLoggedIn() {
        user = AuthRepository.shared.checkUser()
        if user != nil {
            showMainView = true
        }
    }
    
    func loginButtonTapped() {
        Task {
            do {
                user = try await AuthRepository.shared.login(email: email, password: password)
                if let user, let email = user.email {
                    try await StoreRepository.shared.createUser(id: user.uid, email: email, username: username)
                }
                showMainView = true
                
            } catch {
                handleError(error: error)
            }
        }
    }
    
    func registerButtonTapped() {
        Task {
            do {
                user = try await AuthRepository.shared.register(email: email, password: password)
                if let user, let email = user.email {
                    try await StoreRepository.shared.createUser(id: user.uid, email: email, username: username)
                }
                showMainView = true
            } catch {
                handleError(error: error)
            }
        }
    }
    
    func logoutButtonTapped() {
        do {
            try AuthRepository.shared.logout()
            user = nil
            showMainView = false
         
        } catch {
            handleError(error: error)
        }
    }
    
    func deleteButtonTapped() {
        Task {
            do {
                try await AuthRepository.shared.deleteUser()
                user = nil
            } catch {
                handleError(error: error)
            }
        }
    }
    
    private func handleError(error: Error) {
        print(error.localizedDescription)
        
        let errorCode = AuthErrorCode(_nsError: error as NSError)
        switch errorCode.code {
        case .userNotFound:
            errorMessage = "User nicht gefunden"
        case .invalidCredential, .wrongPassword, .invalidEmail:
            errorMessage = "Falsche Zugangsdaten"
        case .userDisabled:
            errorMessage = "Benutzer:in wurde deaktiviert"
        case .emailAlreadyInUse, .accountExistsWithDifferentCredential, .credentialAlreadyInUse:
            errorMessage = "User mit dieser Email besteht bereits"
        case .networkError:
            errorMessage = "Netwerkfehler"
        case .weakPassword:
            errorMessage = "Wählern Sie ein besseres Passwort"
        default:
            errorMessage = "Unbekannter Fehler"
        }
        
        showAlert = true
    }
    
}


