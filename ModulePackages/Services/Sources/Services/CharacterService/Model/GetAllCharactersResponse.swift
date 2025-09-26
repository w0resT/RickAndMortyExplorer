public struct GetAllCharactersResponse: Codable {
    public let info: InfoResponse
    public let results: [CharacterResponse]
}
