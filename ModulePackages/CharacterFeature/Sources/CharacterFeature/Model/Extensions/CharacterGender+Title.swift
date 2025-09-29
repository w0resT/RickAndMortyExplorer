import ApplicationResources

extension CharacterGender {
    var title: String {
        switch self {
        case .male: return Localization.Character.male
        case .female: return Localization.Character.female
        case .genderless: return Localization.Character.genderless
        case .unknown: return Localization.Character.unknown
        }
    }
}
