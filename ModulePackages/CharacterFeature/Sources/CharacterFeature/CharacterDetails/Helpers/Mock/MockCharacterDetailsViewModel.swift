import Foundation

#if DEBUG
final class MockCharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    @Published private(set) var details: CharacterDetailsViewData
    @Published private(set) var loadingState: CharactersDetailsLoadingState
    
    // MARK: - Initialization
    
    init() {
        self.details = .init(character: Character.mock.first!)
        self.loadingState = .none
    }
}
#endif
