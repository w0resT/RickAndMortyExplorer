public struct InfoResponse: Codable {
    public let count: Int
    public let pages: Int
    public let next: String?
    public let prev: String?
}
