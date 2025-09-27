import Foundation

#if DEBUG
final class MockCharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    @Published private(set) var details: CharacterDetailsViewData
    
    // MARK: - Initialization
    
    init() {
        self.details = .init(character: Character.mock.first!)
    }
}
#endif
