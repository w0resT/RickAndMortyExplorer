import SwiftUI

struct CharacterDetailsInfoSection: View {
    
    // MARK: - Properties
    
    private let details: CharacterDetailsViewData
    
    // MARK: - Initialization
    
    init(details: CharacterDetailsViewData) {
        self.details = details
    }
    
    // MARK: - Body Implementation
    
    var body: some View {
        VStack(spacing: 12) {
            CharacterDetailsInfoRow(
                title: "Origin",
                description: details.origin
            )
            
            CharacterDetailsInfoRow(
                title: "Last known location",
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
