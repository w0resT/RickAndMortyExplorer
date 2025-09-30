import UIKit

public extension UIColor {
    static func designSystem(_ token: DSColor) -> UIColor {
        switch token {
        case .primary: return .label
        case .secondary: return .secondaryLabel
        case .background: return .systemBackground
        }
    }
}
