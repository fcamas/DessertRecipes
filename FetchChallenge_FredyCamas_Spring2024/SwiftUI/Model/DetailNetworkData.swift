//
//  DetailNetworkData.swift
//  FetchChallenge_FredyCamas_Spring2024
//
//  Created by Fredy Camas on 1/3/24.
//


import Foundation

struct DessertDetail: Codable {
    var meals: [Detail]
}

struct Detail: Codable, Identifiable {
    var id: String {
        let defaultID = UUID()
        return idMeal ?? "\(defaultID)"
    }
    var idMeal: String?
    var strMeal: String?
    var strDrinkAlternate: String?
    var strCategory: String?
    var strArea: String?
    var strInstructions: String?
    var strMealThumb: String?
    var ingredients: [String]?
    var measures: [String]?

    private enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strDrinkAlternate, strCategory, strArea, strInstructions, strMealThumb

        // Add measure keys
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
        
        // Add ingredient keys
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
    }

    subscript(key: String) -> String? {
        switch key {
        case "idMeal": return idMeal
        case "strMeal": return strMeal
        case "strDrinkAlternate": return strDrinkAlternate
        case "strCategory": return strCategory
        case "strArea": return strArea
        case "strInstructions": return strInstructions
        case "strMealThumb": return strMealThumb
        default:
            return nil
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decodeIfPresent(String.self, forKey: .idMeal)
        strMeal = try container.decodeIfPresent(String.self, forKey: .strMeal)
        strDrinkAlternate = try container.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
        strArea = try container.decodeIfPresent(String.self, forKey: .strArea)
        strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)

        // Dynamic decoding for ingredients and measures
        ingredients = (1...20).compactMap { index in
            guard let key = CodingKeys(rawValue: "strIngredient\(index)") else {
                return nil
            }
            return try? container.decodeIfPresent(String.self, forKey: key)
        }

        measures = (1...20).compactMap { index in
            guard let key = CodingKeys(rawValue: "strMeasure\(index)") else {
                return nil
            }
            return try? container.decodeIfPresent(String.self, forKey: key)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(idMeal, forKey: .idMeal)
        try container.encode(strMeal, forKey: .strMeal)
        try container.encode(strDrinkAlternate, forKey: .strDrinkAlternate)
        try container.encode(strCategory, forKey: .strCategory)
        try container.encode(strArea, forKey: .strArea)
        try container.encode(strInstructions, forKey: .strInstructions)
        try container.encode(strMealThumb, forKey: .strMealThumb)

        // Dynamic encoding for ingredients and measures
        for (index, ingredient) in (ingredients ?? []).enumerated() {
            try container.encode(ingredient, forKey: CodingKeys(rawValue: "strIngredient\(index + 1)")!)
        }

        for (index, measure) in (measures ?? []).enumerated() {
            try container.encode(measure, forKey: CodingKeys(rawValue: "strMeasure\(index + 1)")!)
        }
    }
}
