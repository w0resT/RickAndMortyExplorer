import SwiftUI

struct CharacterFiltersView<ViewModel: CharacterFiltersViewModelProtocol>: View {
    
    // MARK: - Private Properties
    
    @ObservedObject private var viewModel: ViewModel

    // MARK: - Initialization
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body Implementation
    
    var body: some View {
        VStack {
            CharacterFiltersHeaderView(
                onReset: viewModel.resetFilters,
                onApply: viewModel.applyFilters
            )
            
            Form {
                CharacterFiltersSectionFiltersView(
                    status: $viewModel.status,
                    gender: $viewModel.gender
                )
            }
            .scrollDisabled(true)
        }
        .background(Color.primary.opacity(0.1))
    }
}

#if DEBUG
#Preview {
    CharacterFiltersView(viewModel: MockCharacterFiltersViewModel())
}
#endif
