//
//  ChatListViewModel.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 10.05.24.
//

import Foundation
import FirebaseFirestore

final class ChatListViewModel: ObservableObject {
    @Published var users = [User]()
    
    private let firestore = Firestore.firestore()
    private let currentUserId = AuthRepository.shared.checkUser()?.uid ?? ""
    
    func fetchUsers() {
        firestore.collection("users")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching users: \(error.localizedDescription)")
                    return
                }
                
                self.users = querySnapshot?.documents.compactMap { document in
                    guard let user = try? document.data(as: User.self),
                          user.id != self.currentUserId else {
                        return nil
                    }
                    return user
                } ?? []
            }
    }
}
