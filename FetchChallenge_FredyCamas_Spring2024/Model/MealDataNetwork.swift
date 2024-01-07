//
//  Meal.swift
//  FetchChallenge_FredyCamas_Spring2024
//
//  Created by Fredy Camas on 1/3/24.
//

import Foundation

struct MealDataNetwork:Decodable{
    var meals: [Meals]
}

struct Meals: Decodable, Identifiable {
  
    var id :String? {
        return idMeal
    }
    
    var strMeal: String?
    var strMealThumb: String?
    var idMeal: String?
}
