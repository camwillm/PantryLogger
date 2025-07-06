//
//  CodeHelpers.swift
//  PantryLogger
//
//  Created by Cameron Williams on 7/5/25.
//

import SwiftUI

func gradientColor(for daysLeft: Int) -> LinearGradient {
    let clamped = max(0, min(daysLeft, 7))

    let colors: [Color] = [
        .red,
        .orange,
        .pink,
        .yellow,
        .green.opacity(0.7),
        .green,
        .mint,
        .blue
    ]

    return LinearGradient(
        gradient: Gradient(colors: [colors[clamped], colors[min(clamped + 1, 7)]]),
        startPoint: .leading,
        endPoint: .trailing
    )
}
