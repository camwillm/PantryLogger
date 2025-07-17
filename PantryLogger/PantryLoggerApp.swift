//
//  PantryLoggerApp.swift
//  PantryLogger
//
//  Created by Cameron Williams on 7/4/25.
//

import SwiftUI

@main
struct PantryLoggerApp: App {
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(themeManager)
        }
    }
}
