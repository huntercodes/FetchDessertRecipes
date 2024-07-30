//
//  DessertDetailView.swift
//  FetchDessertRecipes
//
//  Created by hunter downey on 7/30/24.
//

import SwiftUI

struct DessertDetailView: View {
    let dessert: Dessert

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let thumbnail = dessert.strMealThumb, let url = URL(string: thumbnail) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Text(dessert.strMeal)
                    .font(.largeTitle)
                    .padding()

                if let instructions = dessert.strInstructions {
                    Text("Instructions")
                        .font(.headline)
                        .padding([.top, .bottom])
                    Text(instructions)
                        .padding()
                }

                Text("Ingredients")
                    .font(.headline)
                    .padding([.top, .bottom])

                ForEach(Array(dessert.ingredientMeasurementPairs().enumerated()), id: \.offset) { index, pair in
                    Text("\(pair.0) - \(pair.1)")
                        .padding(.bottom, 2)
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Dessert Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
