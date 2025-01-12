//
//  StoreRepository.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 19.04.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class StoreRepository {
    
    static let shared: StoreRepository = StoreRepository()
    private let store = Firestore.firestore()
    private let auth = Auth.auth()
    
    private init() {}
    
    func getUser(id: String) async throws -> User {
        return try await store
            .collection("users")
            .document(id)
            .getDocument()
            .data(as: User.self)
    }
    
    func fetchUsers() async throws -> [User] {
        return try await store
            .collection("users")
            .getDocuments()
            .documents
            .map { try $0.data(as: User.self) }
    }
    
    func createUser(id: String, email: String, username: String) async throws {
        do {
            let fireUser = try await getUser(id: id)
            print(fireUser)
        } catch {
            print("Kein User gefunden. Erstelle einen neuen")
            let user = User(id: id, email: email, username: username, createdAt: Date.now.ISO8601Format(), photoURL: "https://www.foto.online/")
            try store.collection("users").document(id).setData(from: user)
        }
    }
}
