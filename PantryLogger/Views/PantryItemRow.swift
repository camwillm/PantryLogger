//
//  PantryItemRow.swift
//  PantryLogger
//
//  Created by Cameron Williams on 7/16/25.
//

import SwiftUI

struct PantryItemRow: View {
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

    private func gradientColor(for daysLeft: Int) -> Color {
        switch daysLeft {
        case ..<0:
            return .red
        case 0...1:
            return .orange
        case 2...5:
            return .yellow
        default:
            return .green
        }
    }
}
