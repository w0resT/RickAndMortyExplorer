import ApplicationResources

enum CharacterFilterStatus: CaseIterable {
    case none
    case alive
    case dead
    case unknown
}

extension CharacterFilterStatus {
    var title: String {
        switch self {
        case .none: return Localization.Character.none
        case .alive: return Localization.Character.alive
        case .dead: return Localization.Character.dead
        case .unknown: return Localization.Character.unknown
        }
    }
}

// MARK: - From CharacterStatus to CharacterFilterStatus

extension CharacterFilterStatus {
    init(from status: CharacterStatus?) {
        guard let status = status else {
            self = .none
            return
        }
        
        switch status {
        case .alive: self = .alive
        case .dead: self = .dead
        case .unknown: self = .unknown
        }
    }
    
    var toCharacterStatus: CharacterStatus? {
        switch self {
        case .none: return nil
        case .alive: return .alive
        case .dead: return .dead
        case .unknown: return .unknown
        }
    }
}
