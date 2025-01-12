//
//  MealView.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 13.05.24.
//

import SwiftUI
import FirebaseDatabase

struct MealView: View {
    @StateObject private var viewModel = MealViewModel.sharedMealViewModel
    @StateObject private var favoritesViewModel = FavoritesViewModel.sharedFavoViewModel
    
    var body: some View {
        VStack {
            if let meal = viewModel.meal {
                VStack {
                    Text(meal.name)
                        .font(.title)
                    
                    AsyncImage(url: URL(string: meal.imageURL)) { image in
                        image
                            .resizable()
                            .frame(width: 350, height: 350)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding()
                    
                    Button(action: {
                        viewModel.toggleFavorite(meal)
                    }) {
                        Image(systemName: viewModel.isFavoriteMeal(meal) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                }
                .padding()
                
                Button(action: {
                    viewModel.fetchRandomMeal()
                }) {
                    Text("Next")
                        .foregroundColor(.white)
                        .padding()
                        .frame(minWidth: 150)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                
                NavigationLink(destination: FavoritesView()) {
                    Text("Fav List")
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle("Random Meals")
        .padding()
        .onAppear {
            viewModel.fetchRandomMeal()
            favoritesViewModel.loadFavorites()
        }
    }
}

#Preview {
    MealView()
}
