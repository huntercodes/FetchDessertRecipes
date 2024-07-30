//
//  DessertService.swift
//  FetchDessertRecipes
//
//  Created by hunter downey on 7/30/24.
//

import Foundation

class DessertService {
    static let shared = DessertService()
    private init() {}

    private let baseURL = "https://themealdb.com/api/json/v1/1"

    func fetchDesserts() async throws -> [Dessert] {
        let url = URL(string: "\(baseURL)/filter.php?c=Dessert")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let dessertListResponse = try JSONDecoder().decode(DessertListResponse.self, from: data)
        
        var detailedDesserts: [Dessert] = []
        try await withThrowingTaskGroup(of: Dessert?.self) { group in
            for dessert in dessertListResponse.meals {
                group.addTask {
                    let detailUrl = URL(string: "\(self.baseURL)/lookup.php?i=\(dessert.idMeal)")!
                    let (detailData, _) = try await URLSession.shared.data(from: detailUrl)
                    let dessertDetailResponse = try JSONDecoder().decode(DessertListResponse.self, from: detailData)
                    return dessertDetailResponse.meals.first
                }
            }
            
            for try await detailedDessert in group {
                if let detailedDessert = detailedDessert {
                    detailedDesserts.append(detailedDessert)
                }
            }
        }
        
        return detailedDesserts.sorted { $0.strMeal < $1.strMeal }
    }
}
