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
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 10)
                            .padding()
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                
                Text(dessert.strMeal)
                    .font(.largeTitle)
                    .padding(.horizontal)
                    .padding(.top)

                if let instructions = dessert.strInstructions {
                    Text("Instructions")
                        .font(.headline)
                        .padding([.top, .horizontal])
                    
                    Text(instructions)
                        .padding(.horizontal)
                }

                Text("Ingredients")
                    .font(.headline)
                    .padding([.top, .horizontal])

                ForEach(Array(dessert.ingredientMeasurementPairs().enumerated()), id: \.offset) { index, pair in
                    HStack {
                        Text(pair.0)
                            .font(.subheadline)
                        
                        Spacer()
                        
                        Text(pair.1)
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 2)
                }
            }
            .padding(.bottom)
        }
        .navigationTitle("Dessert Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
