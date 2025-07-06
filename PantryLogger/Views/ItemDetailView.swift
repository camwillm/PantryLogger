//
//  ItemDetailView.swift
//  PantryLogger
//
//  Created by Cameron Williams on 7/6/25.
//

import SwiftUI

struct ItemDetailView: View {
    let item: PantryItem

    var body: some View {
        Form {
            Section(header: Text("Details")) {
                Text("Name: \(item.name)")
                Text("Brand: \(item.brand)")
                Text("Category: \(item.category)")
                Text("Ingredients: \(item.ingredients)")
                Text("Storage: \(item.location.rawValue.capitalized)")
                if let expiration = item.expirationDate {
                    Text("Expires in: \(item.daysLeft) days")
                    Text("Expiration Date: \(expiration.formatted(date: .abbreviated, time: .omitted))")
                }
            }

            Section(header: Text("Nutrition (per serving)")) {
                Text("Calories: \(item.caloriesPerServing)")
                Text("Protein: \(item.protein, specifier: "%.1f")g")
                Text("Carbs: \(item.carbs, specifier: "%.1f")g")
                Text("Fat: \(item.fat, specifier: "%.1f")g")
            }

            Section(header: Text("Price")) {
                Text("Total: $\(item.price, specifier: "%.2f")")
                Text("Servings: \(item.servingsPerContainer)")
                Text("Price Per Serving: $\(item.pricePerServing, specifier: "%.2f")")
            }
        }
        .navigationTitle(item.name)
    }
}
