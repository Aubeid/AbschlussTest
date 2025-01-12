//
//  MealRepository.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 15.05.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

class MealRepository{
    
    private let db = Firestore.firestore()
    static let shared = MealRepository()
    
    func addFavoriteMeal(_ meal: Meal) {
        let data: [String: Any] = [
            "id": meal.id,
            "name": meal.name,
            "imageURL": meal.imageURL,
            "instructions": meal.instructions
        ]
        
        db.collection("favoriteMeals").document(meal.id).setData(data) { error in
            if let error = error {
                print("Error adding favorite meal: \(error.localizedDescription)")
            } else {
                print("Favorite meal added successfully")
            }
        }
    }
    
    func removeFavoriteMeal(_ meal: Meal) {
        db.collection("favoriteMeals").document(meal.id).delete { error in
            if let error = error {
                print("Error removing favorite meal: \(error.localizedDescription)")
            } else {
                print("Favorite meal removed successfully")
            }
        }
    }
    
    func getFavoriteMeals(completion: @escaping ([Meal]) -> Void) {
        db.collection("favoriteMeals").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting favorite meals: \(error.localizedDescription)")
                completion([])
            } else {
                let favoriteMeals = querySnapshot?.documents.compactMap { document -> Meal? in
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let imageURL = data["imageURL"] as? String ?? ""
                    let instructions = data["instructions"] as? String ?? ""
                    //                    let category = data["category"] as? String ?? ""
                    //                    let area = data["area"] as? String ?? ""
                    //                    let ingredients = data["ingredients"] as? String ?? ""
                    //                    let measures = data["measures"] as? String ?? ""
                    //                    
                    return Meal(id: document.documentID, name: name, imageURL: imageURL, instructions: instructions)
                } ?? []
                
                completion(favoriteMeals)
            }
        }
    }
}
