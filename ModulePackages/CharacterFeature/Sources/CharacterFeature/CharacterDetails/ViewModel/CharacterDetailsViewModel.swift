import Foundation

final class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    @Published private(set) var details: CharacterDetailsViewData
    
    // MARK: - Initialization
    
    init(initialData: CharacterDetailsInitialData) {
        self.details = .init(character: initialData.character)
    }
}
