//
//  DessertServiceProtocol.swift
//  FetchDessertRecipes
//
//  Created by hunter downey on 7/30/24.
//

import Foundation

protocol DessertServiceProtocol {
    func fetchDesserts() async throws -> [Dessert]
}
