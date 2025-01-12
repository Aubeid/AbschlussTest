//
//  AuthRepository.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 19.04.24.
//

import Foundation
import FirebaseAuth

final class AuthRepository {
    
    static let shared = AuthRepository()
    
    let auth = Auth.auth()
    private init() {}
    
    func checkUser() -> FirebaseAuth.User? {
        auth.currentUser
    }
    
    func login(email: String, password: String) async throws -> FirebaseAuth.User {
        let result = try await auth.signIn(withEmail: email, password: password)
        return result.user
    }
    
    func register(email: String, password: String) async throws -> FirebaseAuth.User {
        try await auth.createUser(withEmail: email, password: password)
        return try await login(email: email, password: password)
    }
    
    func logout() throws {
        try auth.signOut()
    }
    
    func deleteUser() async throws {
        try await auth.currentUser?.delete()
    }
}
