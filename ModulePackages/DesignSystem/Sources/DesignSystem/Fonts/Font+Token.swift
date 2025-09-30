import SwiftUI

public extension Font {
    static func designSystem(_ token: DSFont) -> Font {
        return Font(UIFont.designSystem(token))
    }
}
