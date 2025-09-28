public struct CharacterFiltersRequest {
    public let status: String?
    public let gender: String?
    
    public init(
        status: String? = nil,
        gender: String? = nil
    ) {
        self.status = status
        self.gender = gender
    }
}
