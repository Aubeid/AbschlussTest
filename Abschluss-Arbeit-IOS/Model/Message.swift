//
//  Message.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 10.05.24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

final class Message: Identifiable, Codable, ObservableObject {
    let id: UUID
    let text: String
    let senderId: String
    let timestamp: Timestamp
    @Published var senderUsername: String = ""
    @Published var senderPhotoURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case senderId
        case timestamp
    }
    
    init(id: String? = nil, text: String, senderId: String, timestamp: Timestamp) {
        self.id = UUID()
        self.text = text
        self.senderId = senderId
        self.timestamp = timestamp
        
        fetchUserInfo()
    }
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let idString = try container.decode(String.self, forKey: .id)
//        id = UUID(uuidString: idString) ?? UUID() 
//        text = try container.decode(String.self, forKey: .text)
//        senderId = try container.decode(String.self, forKey: .senderId)
//        timestamp = try container.decode(Timestamp.self, forKey: .timestamp)
//        
//        fetchUserInfo()
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encodeIfPresent(id, forKey: .id)
//        try container.encode(text, forKey: .text)
//        try container.encode(senderId, forKey: .senderId)
//        try container.encode(timestamp, forKey: .timestamp)
//    }
    
    private func fetchUserInfo() {
        let userRef = Firestore.firestore().collection("users").document(senderId)
        
        userRef.getDocument { [weak self] document, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching user info: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                self.senderUsername = data?["username"] as? String ?? ""
                
                if let photoURLString = data?["photoURL"] as? String, let photoURL = URL(string: photoURLString) {
                    self.senderPhotoURL = photoURL
                }
            }
        }
    }
}


