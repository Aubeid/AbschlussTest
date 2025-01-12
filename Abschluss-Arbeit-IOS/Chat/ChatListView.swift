//
//  ChatListView.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 10.05.24.
//

import SwiftUI

struct ChatListView: View {
    @StateObject private var viewModel = ChatListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                NavigationLink {
                    ChatView(recipient: user)
                } label: {
                    HStack {
                        if let photoURL = URL(string: user.photoURL ?? "") {
                            AsyncImage(url: photoURL) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 32, height: 32)
                                    .clipShape(Circle())
                            } placeholder: {
                                //ProgressView()
                            }
                        }
                        Text(user.username)
                    }
                }
            }
            .navigationTitle("Chats")
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}

#Preview {
    ChatListView()
}
