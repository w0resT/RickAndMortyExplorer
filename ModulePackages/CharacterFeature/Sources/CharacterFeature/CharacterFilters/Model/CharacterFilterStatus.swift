enum CharacterFilterStatus: CaseIterable {
    case none
    case alive
    case dead
    case unknown
}

extension CharacterFilterStatus {
    var title: String {
        switch self {
        case .none:
            return "None"
        case .alive:
            return "Alive"
        case .dead:
            return "Dead"
        case .unknown:
            return "Unknown"
        }
    }
}

extension CharacterFilterStatus {
    init(from status: CharacterStatus?) {
        guard let status = status else {
            self = .none
            return
        }
        
        switch status {
        case .alive:
            self = .alive
        case .dead:
            self = .dead
        case .unknown:
            self = .unknown
        }
    }
    
    var toCharacterStatus: CharacterStatus? {
        switch self {
        case .none:
            return nil
        case .alive:
            return .alive
        case .dead:
            return .dead
        case .unknown:
            return .unknown
        }
    }
}
