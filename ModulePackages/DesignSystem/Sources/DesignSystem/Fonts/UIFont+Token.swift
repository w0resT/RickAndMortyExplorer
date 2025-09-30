import UIKit

public extension UIFont {
    static func designSystem(_ token: DSFont) -> UIFont {
        switch token {
        case .titleLarge:
            return .boldSystemFont(ofSize: 34)
        case .titleMedium:
            return .boldSystemFont(ofSize: 20)
        case .body:
            return .systemFont(ofSize: 14)
        case .bodySecondary:
            return .systemFont(ofSize: 16)
        case .bodySecondarySemibold:
            return .systemFont(ofSize: 16, weight: .semibold)
        case .caption:
            return .systemFont(ofSize: 12, weight: .medium)
        }
    }
}
