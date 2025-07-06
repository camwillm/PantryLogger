//
//  EditItemView.swift
//  PantryLogger
//
//  Created by Cameron Williams on 7/6/25.
//
import SwiftUI

struct EditItemView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: PantryViewModel
    @State private var item: PantryItem

    init(viewModel: PantryViewModel, item: PantryItem) {
        self.viewModel = viewModel
        _item = State(initialValue: item)
    }

    let categoryOptions = [
        "Beverage → Juice", "Dairy", "Snacks", "Produce",
        "Meat", "Seafood", "Frozen", "Grains",
        "Canned", "Condiments", "Other"
    ]

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $item.name)
                TextField("Brand", text: $item.brand)
                Picker("Category", selection: $item.category) {
                    ForEach(categoryOptions, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                Picker("Storage", selection: $item.location) {
                    ForEach(StorageType.allCases) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
            } header: {
                Text("Basic Info")
            }

            Section {
                TextField("Calories", value: $item.caloriesPerServing, formatter: NumberFormatter())
                TextField("Protein (g)", value: $item.protein, formatter: NumberFormatter())
                TextField("Carbs (g)", value: $item.carbs, formatter: NumberFormatter())
                TextField("Fat (g)", value: $item.fat, formatter: NumberFormatter())
                TextField("Servings", value: $item.servingsPerContainer, formatter: NumberFormatter())
            } header: {
                Text("Nutrition")
            }

            Section {
                TextField("Price", value: $item.price, formatter: NumberFormatter())
                DatePicker("Expiration Date", selection: Binding(
                    get: { item.expirationDate ?? Date() },
                    set: { item.expirationDate = $0 }
                ), displayedComponents: .date)
                TextField("Barcode", text: $item.barcode)
            } header: {
                Text("Price & Expiration")
            }

            Section {
                TextField("Ingredients", text: $item.ingredients)
            } header: {
                Text("Ingredients")
            }
        }
        .navigationTitle("Edit Item")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    viewModel.updateItem(item)
                    dismiss()
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}
