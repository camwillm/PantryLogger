//
//  SampleData.swift
//  PantryLogger
//
//  Created by Cameron Williams on 7/6/25.
//

import Foundation

let samplePantryItems: [PantryItem] = [
    PantryItem(
        name: "Tropicana Orange Juice",
        brand: "Tropicana",
        category: "Beverage → Juice",
        ingredients: "Orange Juice",
        caloriesPerServing: 110,
        servingsPerContainer: 8,
        protein: 2,
        carbs: 26,
        fat: 0,
        price: 3.99,
        barcode: "0123456789012",
        purchaseDate: Date(),
        expirationDate: Calendar.current.date(byAdding: .day, value: 10, to: Date()),
        location: .fridge
    )
]
