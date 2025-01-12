//
//  MealViewModel.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 13.05.24.
//

import Foundation
import Combine


class MealViewModel: ObservableObject {
    static let sharedMealViewModel = MealViewModel()
    @Published var meal: Meal?
    @Published var favoriteMeals: [Meal] = []
    private let apiService = APIService()
    private var cancellables = Set<AnyCancellable>()
    private let repository = MealRepository.shared
    
    init() {
        fetchRandomMeal()
        loadFavoriteMeals()
    }
    
    func fetchRandomMeal() {
        apiService.fetchMeals()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Meals fetched successfully")
                case .failure(let error):
                    print("Error fetching meals: \(error)")
                }
            }, receiveValue: { mealResponse in
                if let meal = mealResponse.meals.randomElement() {
                    self.meal = meal
                } else {
                    self.meal = nil
                }
            })
            .store(in: &cancellables)
    }
    
    func toggleFavorite(_ meal: Meal) {
        if isFavoriteMeal(meal) {
            removeFavoriteMeal(meal)
        } else {
            addFavoriteMeal(meal)
        }
    }
    
    func isFavoriteMeal(_ meal: Meal) -> Bool {
        return favoriteMeals.contains { $0.id == meal.id }
    }
    
    func addFavoriteMeal(_ meal: Meal) {
        repository.addFavoriteMeal(meal)
        favoriteMeals.append(meal)
    }
    
    func removeFavoriteMeal(_ meal: Meal) {
        repository.removeFavoriteMeal(meal)
        favoriteMeals.removeAll { $0.id == meal.id }
    }
    
    func loadFavoriteMeals() {
        repository.getFavoriteMeals { [weak self] favoriteMeals in
            self?.favoriteMeals = favoriteMeals
        }
    }
}
