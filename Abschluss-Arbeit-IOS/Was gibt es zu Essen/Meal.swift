//
//  Meal.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 13.05.24.
//

import Foundation

struct Meal: Identifiable, Codable {
    var id: String
    var name: String
    var imageURL: String
    var instructions: String
//    var category: String
//    var area: String
//    var tags: [String]?
//    var youtubeURL: String?
//    var ingredients: [String]
//    var measures: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageURL = "strMealThumb"
        case instructions = "strInstructions"
//        case category = "strCategory"
//        case area = "strArea"
//        case tags = "strTags"
//        case youtubeURL = "strYoutube"
//        case ingredients = "strIngredient"
//        case measures = "strMeasure"
    }
    

   }

