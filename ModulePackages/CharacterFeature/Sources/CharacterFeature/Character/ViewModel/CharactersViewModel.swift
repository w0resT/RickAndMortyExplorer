import Foundation
import Combine

final class CharactersViewModel {
    
    // MARK: - Properties

    @Published private(set) var characters: [Character]
    @Published private(set) var info: Info?
    @Published private(set) var loadingState: CharactersLoadingState
    @Published var searchQuery: String
    
    private var cancellables = Set<AnyCancellable>()
    private var characterFilters: CharacterFilters
    
    var isLoadingMore: Bool
    var isLastPageReached: Bool {
        return info?.next == nil
    }
    
    private weak var moduleOutput: CharacterModuleOutputProtocol?
    
    // MARK: - Initialization
    
    init(moduleOutput: CharacterModuleOutputProtocol?) {
        self.moduleOutput = moduleOutput
        
        self.info = nil
        self.characters = []
        self.loadingState = .loading
        self.searchQuery = ""
        
        self.isLoadingMore = false
        
        self.characterFilters = CharacterFilters(
            status: nil,
            gender: nil
        )
        
        setuoBindings()
        loadCharacters()
    }
    
    // MARK: - Methods
    
    func setuoBindings() {
        $searchQuery
            .dropFirst()
            .debounce(for: 0.7, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                print("searchQuery: \(text)")
            }
            .store(in: &cancellables)
    }
    
    func loadCharacters() {
        print("loadCharacters")
        
        self.characters = Character.mock
        self.loadingState = .success
    }
    
    func loadMoreCharacters() {
        print("loadMoreCharacters")
        self.isLoadingMore = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isLoadingMore = false
        }
    }
    
    func didSelectCharacter(_ character: Character) {
        moduleOutput?.showCharacterDetails(character: character)
    }
    
    func didTapFilters() {
        moduleOutput?.showCharacterFilters(filters: characterFilters)
    }
}

// MARK: - CharacterModuleInputProtocol

extension CharactersViewModel: CharacterModuleInputProtocol {
    func applyFilters(filters: CharacterFilters) {
        self.characterFilters = filters
    }
}
