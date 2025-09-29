import ApplicationResources

enum CharacterDetailsStatus {
    case alive
    case dead
    case unknown
}

extension CharacterDetailsStatus {
    var title: String {
        switch self {
        case .alive: return Localization.Character.alive
        case .dead: return Localization.Character.dead
        case .unknown: return Localization.Character.unknown
        }
    }
    
    init(from character: CharacterStatus) {
        switch character {
        case .alive: self = .alive
        case .dead: self = .dead
        case .unknown: self = .unknown
        }
    }
}
