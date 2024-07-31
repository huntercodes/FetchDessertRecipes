//
//  MockDessertService.swift
//  FetchDessertRecipesTests
//
//  Created by hunter downey on 7/30/24.
//

import Foundation
@testable import FetchDessertRecipes

class MockDessertService: DessertServiceProtocol {
    
    var mockDesserts: [Dessert] = []
    
    var shouldReturnError = false

    func fetchDesserts() async throws -> [Dessert] {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        return mockDesserts
    }
    
}
