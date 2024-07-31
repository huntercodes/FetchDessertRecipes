//
//  DessertService.swift
//  FetchDessertRecipes
//
//  Created by hunter downey on 7/30/24.
//

import Foundation

class DessertService: DessertServiceProtocol {
    
    static let shared = DessertService()
    
    private let cacheKey = "cachedDesserts"
    
    private init() {}

    private let baseURL = "https://themealdb.com/api/json/v1/1"

    // Attempt to load cached data
    private func loadCachedDesserts() -> [Dessert]? {
        guard let data = UserDefaults.standard.data(forKey: cacheKey) else {
            return nil
        }
        return try? JSONDecoder().decode([Dessert].self, from: data)
    }

    // Attempt to cache the data
    private func saveDessertsToCache(_ desserts: [Dessert]) {
        let data = try? JSONEncoder().encode(desserts)
        UserDefaults.standard.set(data, forKey: cacheKey)
    }

    // Asynchronous function to fetch an array of Dessert
    func fetchDesserts() async throws -> [Dessert] {
        if let cachedDesserts = loadCachedDesserts() {
            return cachedDesserts
        }
        
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
        
        let sortedDesserts = detailedDesserts.sorted { $0.strMeal < $1.strMeal }
        saveDessertsToCache(sortedDesserts)
        return sortedDesserts
    }
    
}
