//
//  FavoritesView.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 13.05.24.
//

import SwiftUI
import FirebaseDatabase

struct FavoritesView: View {
    @ObservedObject private var viewModel = FavoritesViewModel.sharedFavoViewModel
    @State private var errorMessage: String?
    
    
    var body: some View {
        NavigationStack {
            Group {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                } else {
                    List(viewModel.favorites, id: \.id) { meal in
                        VStack(alignment: .leading) {
                            Text(meal.name)
                            
                            AsyncImage(url: URL(string: meal.imageURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 200)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Button(action: {
                                viewModel.removeFavorite(meal)
                            }) {
                                Text("Remove")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle("Favorite Meals")
            .onAppear {
                viewModel.loadFavorites()
            }
        }
       
    }
}

#Preview {
    FavoritesView()
}
