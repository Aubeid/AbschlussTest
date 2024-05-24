//
//  ChatViewModel.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 10.05.24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

final class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()
    let currentUserId: String
    let recipientId: String
    
    private let firestore = Firestore.firestore()
    private let storageRef = Storage.storage().reference()
    
    init(recipient: User) {
        currentUserId = AuthRepository.shared.checkUser()?.uid ?? ""
        recipientId = recipient.id
    }
    
    func fetchMessages() {
        firestore.collection("conversations")
            .document(createConversationId(currentUserId, recipientId))
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching messages: \(error.localizedDescription)")
                    return
                }
                
                self.messages = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Message.self)
                } ?? []
            }
    }
    
    
       func sendMessage(_ text: String) {
           guard let currentUser = AuthRepository.shared.checkUser() else {
               return
           }
           
           let message = Message(text: text, senderId: currentUser.uid, timestamp: Timestamp(date: Date()))
           let conversationId = createConversationId(currentUserId, recipientId)
           
           do {
               let _ = try firestore.collection("conversations")
                   .document(conversationId)
                   .collection("messages")
                   .addDocument(from: message)
           } catch {
               print("Error sending message: \(error.localizedDescription)")
           }
       }
    
    private func createConversationId(_ userId1: String, _ userId2: String) -> String {
        let userIds = [userId1, userId2].sorted()
        return userIds.joined(separator: "_")
    }
}
    
