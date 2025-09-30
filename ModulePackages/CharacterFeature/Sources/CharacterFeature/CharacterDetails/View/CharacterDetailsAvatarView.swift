import SwiftUI
import DesignSystem

struct CharacterDetailsAvatarView: View {
    
    // MARK: - Properties
    
    private let imageData: Data?
    private let state: CharactersDetailsLoadingState
    private let status: CharacterDetailsStatus
    
    // MARK: - Initialization
    
    init(
        imageData: Data?,
        state: CharactersDetailsLoadingState,
        status: CharacterDetailsStatus
    ) {
        self.imageData = imageData
        self.state = state
        self.status = status
    }
    
    // MARK: - Body Implementation
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CharacterDetailsImageView(
                imageData: imageData,
                state: state
            )
            .clipShape(RoundedRectangle(cornerRadius: .designSystem(.corner30)))
            .padding(.top, .designSystem(.padding6))
            
            if state == .success {
                CharacterDetailsImageBadgeView(status: status)
            }
        }
    }
}

#if DEBUG
#Preview {
    CharacterDetailsAvatarView(
        imageData: nil,
        state: .error,
        status: .alive
    )
}
#endif
