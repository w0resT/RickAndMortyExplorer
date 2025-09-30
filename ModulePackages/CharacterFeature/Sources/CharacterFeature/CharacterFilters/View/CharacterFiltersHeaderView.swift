import SwiftUI
import ApplicationResources

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
            Button(Localization.CharacterFilters.Button.reset, action: onReset)
                .padding()
            
            Spacer()
            
            Button(Localization.CharacterFilters.Button.apply, action: onApply)
                .padding()
        }
        .padding(.horizontal, .designSystem(.padding16))
        .padding(.top, .designSystem(.padding4))
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
