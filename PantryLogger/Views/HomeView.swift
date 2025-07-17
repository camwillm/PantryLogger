//  HomeView.swift
//  PantryLogger
//
//  Created by Cameron Williams on 7/5/25.
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject private var viewModel = PantryViewModel()
    @State private var showAddView = false
    @State private var selectedItemForEdit: PantryItem?

    var body: some View {
        NavigationView {
            VStack {
                Picker("Storage Type", selection: $viewModel.selectedStorage) {
                    ForEach(StorageType.allCases) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List {
                    ForEach(viewModel.filteredItems) { item in
                        PantryItemRow(item: item,
                                      viewModel: viewModel,
                                      selectedItemForEdit: $selectedItemForEdit)
                    }
                }
                .listStyle(.plain)
            }
            .background(themeManager.color(for: "Fresh").ignoresSafeArea()) // Use your freshness-based background
            .navigationTitle("Pantry Logger")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddView = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddView) {
                AddItemView(viewModel: viewModel)
                    .environmentObject(themeManager)
            }
            .sheet(item: $selectedItemForEdit) { item in
                EditItemView(viewModel: viewModel, item: item)
                    .environmentObject(themeManager)
            }
        }
    }
}
