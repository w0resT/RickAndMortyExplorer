import Foundation

public extension CGFloat {
    
    // MARK: - DesignSystem Corners
    
    static func designSystem(_ token: DSCorner) -> CGFloat {
        switch token {
        case .corner4: return 4
        case .corner12: return 12
        case .corner16: return 16
        case .corner30: return 30
        }
    }
    
    // MARK: - DesignSystem Paddings
    
    static func designSystem(_ token: DSPadding) -> CGFloat {
        switch token {
        case .padding2: return 2
        case .padding4: return 4
        case .padding6: return 6
        case .padding8: return 8
        case .padding12: return 12
        case .padding16: return 16
        case .padding20: return 20
        }
    }
}
