import ApplicationResources

extension CharacterStatus {
    var title: String {
        switch self {
        case .alive: return Localization.Character.alive
        case .dead: return Localization.Character.dead
        case .unknown: return Localization.Character.unknown
        }
    }
}
