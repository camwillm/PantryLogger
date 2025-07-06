//
//  PantryViewModel.swift
//  PantryLogger
//
//  Created by Cameron Williams on 7/5/25.
//

import SwiftUI

class PantryViewModel: ObservableObject {
    @Published var items: [PantryItem] = []

    @Published var selectedStorage: StorageType = .fridge

    var filteredItems: [PantryItem] {
        items.filter { $0.location == selectedStorage }
    }
    
    func addItem(_ item: PantryItem) {
        items.append(item)
    }
    func updateItem(_ item: PantryItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
        }
    }
    func deleteItem(_ item: PantryItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }
    init() {
        items = samplePantryItems
    }
}
