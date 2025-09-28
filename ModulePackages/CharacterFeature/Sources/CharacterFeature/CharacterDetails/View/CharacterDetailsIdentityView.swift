import SwiftUI

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
            .font(.largeTitle)
            .fontWeight(.bold)
        
        Text("\(species) - \(gender)")
            .font(.subheadline)
            .foregroundColor(.secondary)
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
