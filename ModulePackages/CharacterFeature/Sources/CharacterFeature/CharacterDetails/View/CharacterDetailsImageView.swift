import SwiftUI

struct CharacterDetailsImageView: View {
    
    // MARK: - Properties
    
    private let imageData: Data?
    private let state: CharactersDetailsLoadingState
    
    // MARK: - Initialization
    
    init(
        imageData: Data?,
        state: CharactersDetailsLoadingState
    ) {
        self.imageData = imageData
        self.state = state
    }
    
    // MARK: - Body Implementation
    
    var body: some View {
        if state == .success {
            successView
        } else if state == .loading {
            loadingView
        } else {
            errorView
        }
    }
    
    // MARK: - Private
    
    private var successView: some View {
        if let data = imageData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
        } else {
            Image(systemName: "xmark.circle")
                .resizable()
                .scaledToFill()
        }
    }
    
    private var loadingView: some View {
        ProgressView()
            .controlSize(.large)
    }
    
    private var errorView: some View {
        Image(systemName: "person.crop.circle.badge.xmark")
            .resizable()
            .scaledToFill()
    }
}

#if DEBUG
#Preview {
    CharacterDetailsImageView(
        imageData: nil,
        state: .loading
    )
}
#endif
