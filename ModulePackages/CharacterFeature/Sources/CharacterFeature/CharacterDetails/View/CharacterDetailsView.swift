import SwiftUI
import DesignSystem

typealias CharacterDetailsVM = CharacterDetailsViewModelProtocol

struct CharacterDetailsView<ViewModel: CharacterDetailsVM>: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel: ViewModel

    // MARK: - Initialization
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body Implementation
    
    var body: some View {
        ScrollView {
            VStack(spacing: .designSystem(.padding12)) {
                CharacterDetailsAvatarView(
                    imageData: viewModel.details.imageData,
                    state: viewModel.loadingState,
                    status: viewModel.details.status
                )
    
                Divider().padding(.vertical, .designSystem(.padding4))
                
                CharacterDetailsIdentityView(
                    name: viewModel.details.name,
                    species: viewModel.details.species,
                    gender: viewModel.details.gender
                )
                
                Divider().padding(.vertical, .designSystem(.padding4))
                
                CharacterDetailsInfoSection(details: viewModel.details)
                
                Spacer()
            }
            .padding(.horizontal, .designSystem(.padding12))
        }
    }
}

#if DEBUG
#Preview {
    CharacterDetailsView(viewModel: MockCharacterDetailsViewModel())
}
#endif
