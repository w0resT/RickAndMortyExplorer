import Foundation
import Combine
import OSLog

protocol CharactersViewModelProtocol {
    var characters: [Character] { get }
    var charactersInfo: Info? { get }
    var loadingState: CharactersLoadingState { get }
    var errorMessage: String? { get }
    var searchQuery: String { get set }
    
    var didCharactersChange: AnyPublisher<CharactersChangeEvent, Never> { get }
    var didImageLoad: AnyPublisher<CharactersImageLoadEvent, Never> { get }
}

// MARK: - CharactersViewModelProtocol Implementation

final class CharactersViewModel: CharactersViewModelProtocol {
    
    // MARK: - Properties

    @Published private(set) var characters: [Character]
    @Published private(set) var charactersInfo: Info?
    @Published private(set) var loadingState: CharactersLoadingState
    @Published private(set) var errorMessage: String?
    @Published var searchQuery: String
    
    private let didCharactersChangeSubject = PassthroughSubject<CharactersChangeEvent, Never>()
    var didCharactersChange: AnyPublisher<CharactersChangeEvent, Never> {
        return didCharactersChangeSubject.eraseToAnyPublisher()
    }
    
    private let didImageLoadSubject = PassthroughSubject<CharactersImageLoadEvent, Never>()
    var didImageLoad: AnyPublisher<CharactersImageLoadEvent, Never> {
        return didImageLoadSubject.eraseToAnyPublisher()
    }
    
    private weak var moduleOutput: CharacterModuleOutputProtocol?
    private let services: CharacterModuleServices
    
    private var cancellables = Set<AnyCancellable>()
    private var characterFilters: CharacterFilters
    private var loadingTask: Task<Void, Never>?
    
    var isLastPageReached: Bool {
        return charactersInfo?.next == nil
    }
    
    // MARK: - Initialization
    
    init(
        moduleOutput: CharacterModuleOutputProtocol?,
        services: CharacterModuleServices
    ) {
        self.moduleOutput = moduleOutput
        self.services = services
        
        self.charactersInfo = nil
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
}

// MARK: - CharactersViewModelInputProtocol

extension CharactersViewModel: CharactersViewModelInputProtocol {
    func handle(_ action: CharactersViewAction) {
        switch action {
        case .loadMoreCharacters:
            loadMoreCharacters()
        case .loadImage(let character):
            loadImage(for: character)
        case .selectCharacter(let character):
            moduleOutput?.showCharacterDetails(character: character)
        case .tapFilters:
            moduleOutput?.showCharacterFilters(filters: characterFilters)
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

// MARK: - Helpers

private extension CharactersViewModel {
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
    
    func startLoading(
        nextURL: String? = nil,
        searchQuery: String? = nil,
        append: Bool = false
    ) {
        self.loadingTask?.cancel()
        self.loadingTask = Task { [weak self] in
            await self?.fetchCharacters(
                nextURL: nextURL,
                searchQuery: searchQuery,
                append: append
            )
        }
    }
    
    func loadCharactersInitial() {
        startLoading()
    }
    
    func loadMoreCharacters() {
        let nextURL = charactersInfo?.next
        startLoading(
            nextURL: nextURL,
            append: true)
        
    }
    
    func loadWithFilters() {
        let searchQuery = searchQuery.isEmpty == true ? nil : searchQuery
        startLoading(searchQuery: searchQuery)
    }
    
    func loadWithSearch(query: String) {
        startLoading(searchQuery: query)
    }
    
    @MainActor
    func fetchCharacters(
        nextURL: String? = nil,
        searchQuery: String? = nil,
        append: Bool = false
    ) async {
        if self.loadingState == .loading
            || self.loadingState == .loadingNext {
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
            self.charactersInfo = .init(from: responseCharacters.info)
            
            let newCharacters = responseCharacters.results.map { Character(from: $0) }
            if append {
                let startIndex = characters.count
                let endIndex = startIndex + newCharacters.count
                let indexPaths = (startIndex..<endIndex).map { IndexPath(item: $0, section: 0) }
                
                self.characters.append(contentsOf: newCharacters)
                self.didCharactersChangeSubject.send(.append(indexPaths: indexPaths))
            } else {
                self.characters = newCharacters
                self.didCharactersChangeSubject.send(.reload)
            }
            self.loadingState = .success
        } catch is CancellationError {
            self.loadingState = .cancelled
        } catch {
            let localizedError = error.localizedDescription
            Logger.characters.error("\(localizedError)")
            self.errorMessage = localizedError
            self.loadingState = .error
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
                    self?.didImageLoadSubject.send(.loaded(id: character.id, data: imageData))
                }
            } catch {
                let localizedError = error.localizedDescription
                Logger.characters.error("Image loading for id '\(character.id)': \(localizedError)")
            }
        }
    }
}
