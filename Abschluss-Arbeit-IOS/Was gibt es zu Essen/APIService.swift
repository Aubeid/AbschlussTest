//
//  APIService.swift
//  Abschluss-Arbeit-IOS
//
//  Created by Aubeid Barikzi on 13.05.24.
//

import Foundation
import Combine

class APIService {
    private var cancellables = Set<AnyCancellable>()
    
    func fetchMeals() -> AnyPublisher<MealResponse, Error> {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MealResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
