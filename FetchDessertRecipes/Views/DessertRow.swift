//
//  DessertRow.swift
//  FetchDessertRecipes
//
//  Created by hunter downey on 7/30/24.
//

import SwiftUI

struct DessertRow: View {
    let dessert: Dessert

    var body: some View {
        HStack {
            if let thumbnail = dessert.strMealThumb, let url = URL(string: thumbnail) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 5)
                } placeholder: {
                    ProgressView()
                }
            }
            Text(dessert.strMeal)
                .font(.headline)
                .padding(.leading, 10)
        }
        .padding(.vertical, 5)
    }
}
