//
//  MealDetail.swift
//  FetchDessertRecipes
//
//  Created by hunter downey on 7/30/24.
//

import Foundation

struct MealDetail: Identifiable, Codable {
    let id: String
    let name: String
    let instructions: String
    let ingredients: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        
        var ingredients: [String] = []
        for index in 1...20 {
            let ingredientKey = CodingKeys(stringValue: "strIngredient\(index)")!
            let measureKey = CodingKeys(stringValue: "strMeasure\(index)")!
            
            if let ingredient = try? container.decode(String?.self, forKey: ingredientKey),
               let measure = try? container.decode(String?.self, forKey: measureKey),
               let ingredientUnwrapped = ingredient, !ingredientUnwrapped.isEmpty,
               let measureUnwrapped = measure, !measureUnwrapped.isEmpty {
                ingredients.append("\(ingredientUnwrapped) - \(measureUnwrapped)")
            }
        }
        self.ingredients = ingredients
    }
}
