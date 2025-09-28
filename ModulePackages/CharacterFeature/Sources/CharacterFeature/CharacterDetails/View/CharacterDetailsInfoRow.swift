import SwiftUI

struct CharacterDetailsInfoRow: View {
    
    // MARK: - Properties
    
    private let title: String
    private let description: String
    
    // MARK: - Initialization
    
    init(
        title: String,
        description: String
    ) {
        self.title = title
        self.description = description
    }
    
    // MARK: - Body Implementation
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 4
        ) {
            Text(title)
                .font(.headline)
            
            Text(description)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }
}

#if DEBUG
#Preview {
    CharacterDetailsInfoRow(
        title: "Some details",
        description: "Some description"
    )
}
#endif
