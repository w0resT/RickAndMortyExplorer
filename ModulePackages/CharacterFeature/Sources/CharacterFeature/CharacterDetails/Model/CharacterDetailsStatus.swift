enum CharacterDetailsStatus: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}

extension CharacterDetailsStatus {
    init(from character: CharacterStatus) {
        switch character {
        case .alive:
            self = .alive
        case .dead:
            self = .dead
        case .unknown:
            self = .unknown
        }
    }
}
