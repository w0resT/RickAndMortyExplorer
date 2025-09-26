public struct Character: Codable {
    public let id: Int
    public let name: String
    public let status: CharacterStatus
    public let species: String
    public let type: String
    public let gender: CharacterGender
    public let origin: CharacterOrigin
    public let location: CharacterLocation
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
}
