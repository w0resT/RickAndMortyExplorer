import SwiftUI

struct CharacterDetailsView<ViewModel: CharacterDetailsViewModelProtocol>: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel: ViewModel

    // MARK: - Initialization
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body Implementation
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                CharacterDetailsAvatarView(
                    imageData: viewModel.details.imageData,
                    state: viewModel.loadingState,
                    status: viewModel.details.status
                )
    
                Divider().padding(.vertical, 4)
                
                CharacterDetailsIdentityView(
                    name: viewModel.details.name,
                    species: viewModel.details.species,
                    gender: viewModel.details.gender
                )
                
                Divider().padding(.vertical, 4)
                
                CharacterDetailsInfoSection(details: viewModel.details)
                
                Spacer()
            }
            .padding(.horizontal, 12)
        }
    }
}

#if DEBUG
#Preview {
    CharacterDetailsView(viewModel: MockCharacterDetailsViewModel())
}
#endif
