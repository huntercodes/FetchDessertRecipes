//
//  ContentView.swift
//  FetchDessertRecipes
//
//  Created by hunter downey on 7/30/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = DessertViewModel()

    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView()
                    .navigationTitle("Dessert Recipes")
                    .navigationBarTitleDisplayMode(.inline)
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .navigationTitle("Dessert Recipes")
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                List(viewModel.desserts) { dessert in
                    NavigationLink(destination: DessertDetailView(dessert: dessert)) {
                        DessertRow(dessert: dessert)
                    }
                }
                .navigationTitle("Dessert Recipes")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onAppear {
            viewModel.fetchDesserts()
        }
        .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    ContentView()
}
