import Foundation

protocol CharacterDetailsViewModelProtocol: ObservableObject {
    var details: CharacterDetailsViewData { get }
    var loadingState: CharactersDetailsLoadingState { get }
}

// MARK: - CharacterDetailsViewModelProtocol Implementation

final class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    @Published private(set) var details: CharacterDetailsViewData
    @Published private(set) var loadingState: CharactersDetailsLoadingState
    
    private let services: DetailsModuleServices
    private var loadingTask: Task<Void, Never>?
    
    // MARK: - Initialization
    
    init(
        services: DetailsModuleServices,
        initialData: CharacterDetailsInitialData
    ) {
        self.services = services
        self.details = .init(character: initialData.character)
        self.loadingState = .none
        
        loadImage(imageURL: initialData.character.image)
    }
    
    deinit {
        loadingTask?.cancel()
    }
}

// MARK: - Helpers

private extension CharacterDetailsViewModel {
    func loadImage(imageURL: String) {
        loadingTask?.cancel()
        loadingTask = Task { [weak self] in
            await self?.fetchImage(imageURL: imageURL)
        }
    }
    
    @MainActor
    func fetchImage(imageURL: String) async {
        self.loadingState = .loading
        
        do {
            let imageData = try await services.imageLoader.fetchImage(imageURL)
            details.imageData = imageData
            
            self.loadingState = .success
        } catch is CancellationError {
            print("fetchImage cancelled")
            self.loadingState = .cancelled
        } catch {
            let localizedError = error.localizedDescription
            print(localizedError)
            self.loadingState = .error
        }
    }
}
