//
//  ChatView.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 10.05.24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel
       @State private var messageText = ""
    
   
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.messages) { message in
                        HStack {
                            if message.senderId == viewModel.currentUserId {
                                Spacer()
                                MessageView(message: message, isCurrentUser: true)
                            } else {
                                MessageView(message: message, isCurrentUser: false)
                                Spacer()
                            }
                        }
                    }
                }
            }
            
            HStack {
                TextField("Type a message...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: sendMessage) {
                    Text("Send")
                }
            }
            .padding()
        }
        .padding(.top)
        .onAppear {
            viewModel.fetchMessages()
        }
    }
    
    
    
    init(recipient: User? = nil) {
        if let recipient = recipient {
            _viewModel = StateObject(wrappedValue: ChatViewModel(recipient: recipient))
        } else {
            let placeholderUser = User(id: "", email: "", username: "Placeholder", createdAt: "", photoURL: nil)
            _viewModel = StateObject(wrappedValue: ChatViewModel(recipient: placeholderUser))
        }
    }
    
    func sendMessage() {
        viewModel.sendMessage(messageText)
        messageText = ""
    }
}


#Preview {
    ChatView()
}
