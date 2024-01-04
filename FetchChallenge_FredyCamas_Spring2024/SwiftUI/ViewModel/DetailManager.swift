//
//  DetailModel.swift
//  FetchChallenge_FredyCamas_Spring2024
//
//  Created by Fredy Camas on 1/3/24.
//


import Foundation

import Foundation

class DessertViewModel: ObservableObject {

    @Published var detailMeal = [Detail]()

    // MARK: Fetch Dessert Detail

    func fetchDessertDetail(id: String) {
        detailMeal = []
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else { return }
        print(url)

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // Use this line if your JSON keys are in snake_case

                let results = try decoder.decode(DessertDetail.self, from: data)
                DispatchQueue.main.async {
                    print(results.meals)

                    // Create arrays for ingredients and measures
                    var ingredients: [String] = []
                    var measures: [String] = []

                    for meal in results.meals {
                        for index in 1...20 {
                            let ingredientKey = "strIngredient\(index)"
                            let measureKey = "strMeasure\(index)"

                            if let ingredient = meal[ingredientKey], !ingredient.isEmpty {
                                ingredients.append(ingredient)
                            }

                            if let measure = meal[measureKey], !measure.isEmpty {
                                measures.append(measure)
                            }
                        }
                        
                    }

                    print(self.detailMeal)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
