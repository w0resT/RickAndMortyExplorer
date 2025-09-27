public struct CharacterResponse: Codable {
    public let id: Int
    public let name: String
    public let status: CharacterStatusResponse
    public let species: String
    public let type: String
    public let gender: CharacterGenderResponse
    public let origin: CharacterOriginResponse
    public let location: CharacterLocationResponse
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
}
