//
//  FavoritesViewModel.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 13.05.24.
//

import Foundation
import FirebaseDatabase
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Meal] = []
    private let repository = MealRepository.shared
    static let sharedFavoViewModel = FavoritesViewModel()
    
    init() {
        loadFavorites()
    }
    
    func loadFavorites() {
        repository.getFavoriteMeals { [weak self] favoriteMeals in
            self?.favorites = favoriteMeals
        }
    }
    
    func addFavorite(_ meal: Meal) {
        repository.addFavoriteMeal(meal)
        favorites.append(meal)
    }
    
    func removeFavorite(_ meal: Meal) {
        favorites.removeAll { $0.id == meal.id }
        repository.removeFavoriteMeal(meal)
    }
}
