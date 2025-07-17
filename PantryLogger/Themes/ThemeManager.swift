import SwiftUI

class ThemeManager: ObservableObject {
    @Published var selectedTheme: ThemeType = .freshClean

    func color(for freshness: String) -> Color {
        switch selectedTheme {
        case .freshClean:
            return colorFromTheme(FreshCleanTheme(), freshness)
        case .warmPantry:
            return colorFromTheme(WarmPantryTheme(), freshness)
        case .chillFridge:
            return colorFromTheme(ChillFridgeTheme(), freshness)
        }
    }

    var backgroundColor: Color {
        switch selectedTheme {
        case .freshClean:
            return Color(hex: "#F6F8FA")
        case .warmPantry:
            return Color(hex: "#FFF3E0") 
        case .chillFridge:
            return Color(hex: "#E3F2FD")
        }
    }

    private func colorFromTheme(_ theme: ColorThemeProtocol, _ freshness: String) -> Color {
        switch freshness {
        case "Fresh": return theme.fresh
        case "Soon": return theme.soon
        case "Use ASAP": return theme.asap
        case "Expired": return theme.expired
        default: return .gray
        }
    }
}
