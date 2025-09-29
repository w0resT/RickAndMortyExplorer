public protocol CharacterServiceProtocol {
    func fetchCharacters(
        nextURL: String?,
        searchQuery: String?,
        filters: CharacterFiltersRequest
    ) async throws -> GetAllCharactersResponse
}

// MARK: - CharacterServiceProtocol Implementation

public class CharacterService: CharacterServiceProtocol {
    
    // MARK: - Properties
    
    private let networkClient: NetworkClientProtocol
    
    // MARK: - Initialization
    
    public init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    // MARK: - CharacterServiceProtocol
    
    public func fetchCharacters(
        nextURL: String?,
        searchQuery: String?,
        filters: CharacterFiltersRequest
    ) async throws -> GetAllCharactersResponse{
        let charactersEndpoint = CharactersEndpoint(
            nextURL: nextURL,
            searchQuery: searchQuery,
            filters: filters
        )
        
        return try await self.networkClient.request(charactersEndpoint)
    }
}
