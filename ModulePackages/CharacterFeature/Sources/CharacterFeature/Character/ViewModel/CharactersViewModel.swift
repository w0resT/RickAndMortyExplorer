import Foundation
import Combine

final class CharactersViewModel {
    
    // MARK: - Properties

    @Published private(set) var characters: [Character]
    @Published private(set) var info: Info?
    @Published private(set) var loadingState: CharactersLoadingState
    
    private weak var moduleOutput: CharacterModuleOutputProtocol?
    
    // MARK: - Initialization
    
    init(moduleOutput: CharacterModuleOutputProtocol?) {
        self.moduleOutput = moduleOutput
        
        self.info = nil
        self.characters = Character.mock
        self.loadingState = .loading
        
        self.loadingState = .success
    }
    
    // MARK: - Methods
    
    func didSelectCharacter(_ character: Character) {
        moduleOutput?.showCharacterDetails(character: character)
    }
    
    func needToShowNextLoadingIndicator() -> Bool {
        return info?.next != nil
    }
}
