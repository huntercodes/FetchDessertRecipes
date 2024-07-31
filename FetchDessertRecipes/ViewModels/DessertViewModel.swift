//
//  DessertViewModel.swift
//  FetchDessertRecipes
//
//  Created by hunter downey on 7/30/24.
//

import SwiftUI

class DessertViewModel: ObservableObject {
    
    @Published var desserts: [Dessert] = []
    
    @Published var isLoading = false
    
    @Published var errorMessage: String?

    private let service: DessertServiceProtocol

    init(service: DessertServiceProtocol = DessertService.shared) {
        self.service = service
    }

    func fetchDesserts() {
        Task {
            do {
                DispatchQueue.main.async {
                    self.isLoading = true
                }
                let fetchedDesserts = try await service.fetchDesserts()
                DispatchQueue.main.async {
                    self.desserts = fetchedDesserts
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
}
