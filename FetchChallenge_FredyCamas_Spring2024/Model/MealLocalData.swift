//
//  MealLocalData.swift
//  FetchChallenge_FredyCamas_Spring2024
//
//  Created by Fredy Camas on 1/3/24.
//

import Foundation

struct MealLocalData: Decodable{
    var id:String
    var name:String
    var urlImage: String
 
    init(meals: Meals) {
        self.id = meals.id  ?? ""
        self.name = meals.strMeal ?? "Unkwon"
        self.urlImage = meals.strMealThumb ?? ""
    }
}
