import Foundation
import Combine

final class CharactersViewModel {
    
    // MARK: - Properties

    @Published private(set) var characters: [Character]
    @Published private(set) var info: Info?
    @Published private(set) var loadingState: CharactersLoadingState
    @Published private(set) var errorMessage: String?
    @Published var searchQuery: String
    
    internal let charactersChange = PassthroughSubject<CharactersChange, Never>()
    internal let imageLoads = PassthroughSubject<(id: Int, data: Data), Never>()
    
    private weak var moduleOutput: CharacterModuleOutputProtocol?
    private let services: CharacterModuleServices
    
    private var cancellables = Set<AnyCancellable>()
    private var characterFilters: CharacterFilters
    
    private var loadingTask: Task<Void, Never>?
    
    var isLastPageReached: Bool {
        return info?.next == nil
    }
    
    // MARK: - Initialization
    
    init(
        moduleOutput: CharacterModuleOutputProtocol?,
        services: CharacterModuleServices
    ) {
        self.moduleOutput = moduleOutput
        self.services = services
        
        self.info = nil
        self.characters = []
        self.loadingState = .none
        self.searchQuery = ""
        
        self.characterFilters = CharacterFilters(
            status: nil,
            gender: nil
        )
        
        setupBindings()
        loadCharactersInitial()
    }
    
    deinit {
        loadingTask?.cancel()
    }
    
    // MARK: - Methods
    
    func setupBindings() {
        $searchQuery
            .dropFirst(2)
            .debounce(for: 0.7, scheduler: DispatchQueue.main)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .removeDuplicates()
            .sink { [weak self] text in
                self?.loadWithSearch(query: text)
            }
            .store(in: &cancellables)
    }
    
    func loadMoreCharacters() {
        self.loadingTask?.cancel()
        self.loadingTask = Task { [weak self] in
            let nextURL = self?.info?.next
            await self?.fetchCharacters(
                nextURL: nextURL,
                append: true
            )
        }
    }
    
    func loadImage(for character: Character) {
        let urlString = character.image
        
        Task { [weak self] in
            do {
                guard let imageData = try await self?.services.imageLoader.fetchImage(urlString) else {
                    return
                }
                
                await MainActor.run { [weak self] in
                    self?.imageLoads.send((id: character.id, data: imageData))
                }
            } catch {
                print("Image loading for id '\(character.id)' error: ")
            }
        }
    }
    
    func didSelectCharacter(_ character: Character) {
        moduleOutput?.showCharacterDetails(character: character)
    }
    
    func didTapFilters() {
        moduleOutput?.showCharacterFilters(filters: characterFilters)
    }
}

// MARK: - Helpers

private extension CharactersViewModel {
    func loadCharactersInitial() {
        self.loadingTask = Task { [weak self] in
            await self?.fetchCharacters()
        }
    }
    
    func loadWithFilters() {
        self.loadingTask?.cancel()
        self.loadingTask = Task { [weak self] in
            let searchQuery = self?.searchQuery.isEmpty == true ? nil : self?.searchQuery
            await self?.fetchCharacters(
                searchQuery: searchQuery,
                append: false
            )
        }
    }
    
    func loadWithSearch(query: String) {
        self.loadingTask?.cancel()
        self.loadingTask = Task { [weak self] in
            await self?.fetchCharacters(
                searchQuery: query,
                append: false
            )
        }
    }
    
    @MainActor
    func fetchCharacters(
        nextURL: String? = nil,
        searchQuery: String? = nil,
        append: Bool = false
    ) async {
        if self.loadingState == .loading || self.loadingState == .loadingNext {
            print("already loading")
            return
        }
    
        if append {
            self.loadingState = .loadingNext
        } else {
            self.loadingState = .loading
        }
        
        do {
            let responseCharacters = try await services.characterService.fetchCharacters(
                nextURL: nextURL,
                searchQuery: searchQuery,
                filters: .init(
                    status: characterFilters.status?.rawValue,
                    gender: characterFilters.gender?.rawValue
                )
            )
            
            let newCharacters = responseCharacters.results.map { Character(from: $0) }
            
            self.info = .init(from: responseCharacters.info)
            
            if append {
                let startIndex = characters.count
                let endIndex = startIndex + newCharacters.count
                let indexPaths = (startIndex..<endIndex).map { IndexPath(item: $0, section: 0) }
                
                self.characters.append(contentsOf: newCharacters)
                self.charactersChange.send(.append(indexPaths: indexPaths))
                self.loadingState = .success
            } else {
                self.characters = newCharacters
                self.charactersChange.send(.reload)
                self.loadingState = .success
            }
        } catch is CancellationError {
            print("loadingTask cancelled")
            self.loadingState = .cancelled
        } catch {
            let localizedError = error.localizedDescription
            print(localizedError)
            self.errorMessage = localizedError
            self.loadingState = .error
        }
    }
}

// MARK: - CharacterModuleInputProtocol

extension CharactersViewModel: CharacterModuleInputProtocol {
    func applyFilters(filters: CharacterFilters) {
        if filters.gender != self.characterFilters.gender
            || filters.status != self.characterFilters.status {
            self.characterFilters = filters
            loadWithFilters()
        }
    }
}
