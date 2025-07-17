import SwiftUI

struct FreshCleanTheme: ColorThemeProtocol {
    let fresh = Color(hex: "#A8E6CF")
    let soon = Color(hex: "#FFD3B6")
    let asap = Color(hex: "#FF8B94")
    let expired = Color(hex: "#D7263D")
}

struct WarmPantryTheme: ColorThemeProtocol {
    let fresh = Color(hex: "#FFF082")
    let soon = Color(hex: "#FFCC80")
    let asap = Color(hex: "#FFB74D")
    let expired = Color(hex: "#E64A19")
}

struct ChillFridgeTheme: ColorThemeProtocol {
    let fresh = Color(hex: "#81D4FA")
    let soon = Color(hex: "#4FC3F7")
    let asap = Color(hex: "#29B6F6")
    let expired = Color(hex: "#0288D1")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255
        )
    }
}

