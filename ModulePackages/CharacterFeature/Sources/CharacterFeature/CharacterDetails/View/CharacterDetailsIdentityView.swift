import SwiftUI
import DesignSystem

struct CharacterDetailsIdentityView: View {
    
    // MARK: - Properties
    
    private let name: String
    private let species: String
    private let gender: String
    
    // MARK: - Initialization
    
    init(
        name: String,
        species: String,
        gender: String
    ) {
        self.name = name
        self.species = species
        self.gender = gender
    }
    
    // MARK: - Body Implementation
    
    var body: some View {
        Text(name)
            .font(.designSystem(.titleLarge))
        
        Text("\(species) - \(gender)")
            .font(.designSystem(.bodySecondary))
            .foregroundColor(.designSystem(.secondary))
    }
}

#if DEBUG
#Preview {
    CharacterDetailsIdentityView(
        name: "Test Test",
        species: "Human",
        gender: "Male"
    )
}
#endif
