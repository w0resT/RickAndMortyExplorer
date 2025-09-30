import SwiftUI

public extension Color {
    static func designSystem(_ token: DSColor) -> Color {
        return Color(UIColor.designSystem(token))
    }
}
