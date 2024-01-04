//
//  DetailNetworkData.swift
//  FetchChallenge_FredyCamas_Spring2024
//
//  Created by Fredy Camas on 1/3/24.
//

import Foundation

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
            if let key = CodingKeys(rawValue: "strIngredient\(index)"),
               let ingredient = try? container.decodeIfPresent(String.self, forKey: key) {
                return ingredient
            } else {
                return nil
            }
        }
        
        measures = (1...20).compactMap { index in
            if let key = CodingKeys(rawValue: "strMeasure\(index)"),
               let measure = try? container.decodeIfPresent(String.self, forKey: key) {
                return measure
            } else {
                return nil
            }
        }
    }
}
