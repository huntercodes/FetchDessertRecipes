//
//  DessertViewModelTests.swift
//  FetchDessertRecipesTests
//
//  Created by hunter downey on 7/30/24.
//

import XCTest
@testable import FetchDessertRecipes

// Core Unit Tests
class DessertViewModelTests: XCTestCase {

    var viewModel: DessertViewModel!
    
    var mockService: MockDessertService!

    override func setUp() {
        super.setUp()
        mockService = MockDessertService()
        viewModel = DessertViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    // Verifies DessertViewModel correctly fetches and processes data when the network request is successful
    func testFetchDessertsSuccess() {
        let expectation = self.expectation(description: "Fetch desserts successfully")
        
        mockService.mockDesserts = [
            Dessert(idMeal: "1", strMeal: "Test Meal", strMealThumb: nil, strInstructions: "Test instructions", strIngredient1: "Test Ingredient 1", strIngredient2: nil, strIngredient3: nil, strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: "1 cup", strMeasure2: nil, strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil)
        ]
        
        viewModel.fetchDesserts()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.desserts.count, 1)
            XCTAssertEqual(self.viewModel.desserts.first?.strMeal, "Test Meal")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }

    // Ensures DessertViewModel handles error gracefully when the network request fails
    func testFetchDessertsFailure() {
        let expectation = self.expectation(description: "Fetch desserts failure")
        
        mockService.shouldReturnError = true
        
        viewModel.fetchDesserts()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.desserts.count, 0)
            XCTAssertNotNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
}
