//
//  MessageView.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 10.05.24.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    let isCurrentUser: Bool
    
    var body: some View {
        HStack(alignment: .bottom) {
            if !isCurrentUser {
                VStack(alignment: .leading, spacing: 4) {
                    Text(message.senderUsername)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    if let photoURL = message.senderPhotoURL {
                        AsyncImage(url: photoURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 32, height: 32)
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
            
            Text(message.text)
                .padding(8)
                .background(isCurrentUser ? Color.blue : Color(UIColor.systemGray5))
                .cornerRadius(8)
            
            if isCurrentUser {
                VStack(alignment: .trailing, spacing: 4) {
                    Text(message.senderUsername)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    if let photoURL = message.senderPhotoURL {
                        AsyncImage(url: photoURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 32, height: 32)
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    MessageView(message: Message(id: "", text: "Hey was geht", senderId: "02121", timestamp: Date.now.ISO8601Format(), isCurrentUser: true), isCurrentUser: true}
