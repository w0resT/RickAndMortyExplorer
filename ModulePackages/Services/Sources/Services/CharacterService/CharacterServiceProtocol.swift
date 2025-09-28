public protocol CharacterServiceProtocol {
    func fetchCharacters(
        nextURL: String?,
        searchQuery: String?,
        filters: CharacterFiltersRequest
    ) async throws -> GetAllCharactersResponse
}
