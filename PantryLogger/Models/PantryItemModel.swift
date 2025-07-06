//
//  PantryItemModel.swift
//  PantryLogger
//
//  Created by Cameron Williams on 7/4/25.
//

import SwiftUI

enum StorageType: String, CaseIterable, Identifiable, Codable {
    case fridge, pantry
    var id: String { self.rawValue }
}

struct PantryItem: Identifiable, Codable {
    let id = UUID()
    var name: String
    var brand: String
    var category: String
    var ingredients: String
    var caloriesPerServing: Int
    var servingsPerContainer: Int
    var protein: Double
    var carbs: Double
    var fat: Double
    var price: Double
    var barcode: String
    var purchaseDate: Date
    var expirationDate: Date?
    var location: StorageType

    var pricePerServing: Double {
        servingsPerContainer > 0 ? price / Double(servingsPerContainer) : 0
    }

    var daysLeft: Int {
        guard let expiration = expirationDate else { return Int.max }
        return Calendar.current.dateComponents([.day], from: Date(), to: expiration).day ?? 0
    }

    var freshnessStatus: (String, Color) {
        switch daysLeft {
        case ..<0: return ("Expired", .gray)
        case 0...2: return ("Use ASAP", .red)
        case 3...6: return ("Soon", .yellow)
        default: return ("Fresh", .green)
        }
    }
}
