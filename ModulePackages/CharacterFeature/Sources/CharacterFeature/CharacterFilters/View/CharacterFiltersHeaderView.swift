import SwiftUI

struct CharacterFiltersHeaderView: View {
    
    // MARK: - Properties
    
    private let onReset: () -> Void
    private let onApply: () -> Void
    
    // MARK: - Initialization
    
    init(
        onReset: @escaping () -> Void,
        onApply: @escaping () -> Void
    ) {
        self.onReset = onReset
        self.onApply = onApply
    }

    // MARK: - Body Implementation
    
    var body: some View {
        HStack {
            Button("Reset", action: onReset)
                .padding()
            
            Spacer()
            
            Button("Apply", action: onApply)
                .padding()
        }
        .padding(.horizontal, 15)
        .padding(.top, 3)
    }
}

#if DEBUG
#Preview {
    CharacterFiltersHeaderView(
        onReset: {},
        onApply: {}
    )
}
#endif
