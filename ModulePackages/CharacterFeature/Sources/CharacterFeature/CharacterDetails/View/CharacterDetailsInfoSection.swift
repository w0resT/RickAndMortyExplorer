import SwiftUI
import DesignSystem
import ApplicationResources

struct CharacterDetailsInfoSection: View {
    
    // MARK: - Properties
    
    private let details: CharacterDetailsViewData
    
    // MARK: - Initialization
    
    init(details: CharacterDetailsViewData) {
        self.details = details
    }
    
    // MARK: - Body Implementation
    
    var body: some View {
        VStack(spacing: .designSystem(.padding12)) {
            CharacterDetailsInfoRow(
                title: Localization.CharacterDetails.origin,
                description: details.origin
            )
            
            CharacterDetailsInfoRow(
                title: Localization.CharacterDetails.location,
                description: details.location
            )
        }
    }
}

#if DEBUG
#Preview {
    CharacterDetailsInfoSection(details: .init(character: Character.mock.first!))
}
#endif
