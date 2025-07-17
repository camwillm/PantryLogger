//
//  AddItemView.swift
//  PantryLogger
//
//  Created by Cameron Williams on 7/6/25.
//
import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: PantryViewModel

    @State private var name = ""
    @State private var brand = ""
    @State private var category = ""
    @State private var ingredients = ""
    @State private var calories = ""
    @State private var protein = ""
    @State private var carbs = ""
    @State private var fat = ""
    @State private var servings = ""
    @State private var price = ""
    @State private var barcode = ""
    @State private var location: StorageType = .fridge
    @State private var expirationDate = Date()

    @State private var showScanner = false

    let categoryOptions = [
        "Beverage → Juice", "Dairy", "Snacks", "Produce",
        "Meat", "Seafood", "Frozen", "Grains",
        "Canned", "Condiments", "Other"
    ]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Barcode")) {
                    HStack {
                        TextField("Barcode", text: $barcode)
                        Button(action: {
                            showScanner = true
                        }) {
                            Image(systemName: "barcode.viewfinder")
                                .font(.title2)
                        }
                        .padding(.leading, 5)
                    }
                }

                Section(header: Text("Basic Info")) {
                    TextField("Name", text: $name)
                    TextField("Brand", text: $brand)
                    Picker("Category", selection: $category) {
                        ForEach(categoryOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("Storage", selection: $location) {
                        ForEach(StorageType.allCases) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                }

                Section(header: Text("Nutrition (per serving)")) {
                    TextField("Calories", text: $calories).keyboardType(.numberPad)
                    TextField("Protein (g)", text: $protein).keyboardType(.decimalPad)
                    TextField("Carbs (g)", text: $carbs).keyboardType(.decimalPad)
                    TextField("Fat (g)", text: $fat).keyboardType(.decimalPad)
                    TextField("Servings per container", text: $servings).keyboardType(.numberPad)
                }

                Section(header: Text("Price & Expiration")) {
                    TextField("Price", text: $price).keyboardType(.decimalPad)
                    DatePicker("Expiration Date", selection: $expirationDate, displayedComponents: .date)
                }

                Section(header: Text("Ingredients")) {
                    TextField("Ingredients", text: $ingredients)
                }
            }
            .navigationTitle("Add Item")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let item = PantryItem(
                            name: name,
                            brand: brand,
                            category: category,
                            ingredients: ingredients,
                            caloriesPerServing: Int(calories) ?? 0,
                            servingsPerContainer: Int(servings) ?? 1,
                            protein: Double(protein) ?? 0,
                            carbs: Double(carbs) ?? 0,
                            fat: Double(fat) ?? 0,
                            price: Double(price) ?? 0,
                            barcode: barcode,
                            purchaseDate: Date(),
                            expirationDate: expirationDate,
                            location: location
                        )
                        viewModel.addItem(item)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .sheet(isPresented: $showScanner) {
                BarcodeScannerView { scannedCode in
                    barcode = scannedCode
                    autofillData(for: scannedCode)
                    showScanner = false
                }
            }
        }
    }

    private func autofillData(for barcode: String) {
        // Replace this stub with real API lookup or database fetch.
        if barcode == "0123456789012" {
            name = "Tropicana 100% Orange Juice"
            brand = "Tropicana"
            category = "Beverage → Juice"
            ingredients = "Orange juice"
            calories = "110"
            protein = "2"
            carbs = "26"
            fat = "0"
            servings = "8"
            price = "3.99"
        }
    }
}
