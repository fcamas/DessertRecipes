//
//  DetailModel.swift
//  FetchChallenge_FredyCamas_Spring2024
//
//  Created by Fredy Camas on 1/3/24.
//


import Foundation

import Foundation

class DessertViewModel: ObservableObject {

    @Published var detailMeal = [DetailLocalData]()

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
                decoder.keyDecodingStrategy = .convertFromSnakeCase 
                let results = try decoder.decode(DessertDetail.self, from: data)
                DispatchQueue.main.async {
                    // Create arrays for ingredients and measures
                    var ingredients: [String] = []
                    var measures: [String] = []

                    for meal in results.meals {
                        for index in 1...20 {
                            let ingredientKey = "strIngredient\(index)"
                            let measureKey = "strMeasure\(index)"

                            if let ingredient = meal[ingredientKey], !ingredient.isEmpty {
                                ingredients.append(ingredient)
                                print(ingredient)
                            }

                            if let measure = meal[measureKey], !measure.isEmpty {
                                measures.append(measure)
                            }
                        }
                     
                        let detail = DetailLocalData(id: meal.id, instructions: meal.strInstructions ?? "", ingredients: meal.ingredients, measures: meal.measures)
                        self.detailMeal.append(detail)
                    }
                   
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
