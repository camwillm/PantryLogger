//  HomeView.swift
//  PantryLogger
//
//  Created by Cameron Williams on 7/5/25.
//
import SwiftUI

struct HomeView: View {
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
                        PantryItemRow(item: item, viewModel: viewModel, selectedItemForEdit: $selectedItemForEdit)
                    }
                }
            }
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
            }
            .sheet(item: $selectedItemForEdit) { item in
                EditItemView(viewModel: viewModel, item: item)
            }
        }
    }
}

private struct PantryItemRow: View {
    let item: PantryItem
    var viewModel: PantryViewModel
    @Binding var selectedItemForEdit: PantryItem?

    var body: some View {
        NavigationLink(destination: ItemDetailView(item: item)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                    Text("Expires in \(item.daysLeft) day\(item.daysLeft == 1 ? "" : "s")")
                        .font(.caption)
                }
                Spacer()
                Circle()
                    .fill(gradientColor(for: item.daysLeft))
                    .frame(width: 20, height: 20)
            }
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                viewModel.deleteItem(item)
            } label: {
                Label("Delete", systemImage: "trash")
            }

            Button {
                selectedItemForEdit = item
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.blue)
        }
    }
}
