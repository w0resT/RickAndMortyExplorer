import ApplicationResources

enum CharacterFilterGender: CaseIterable {
    case none
    case male
    case female
    case genderless
    case unknown
}

extension CharacterFilterGender {
    var title: String {
        switch self {
        case .none: return Localization.Character.none
        case .male: return Localization.Character.male
        case .female: return Localization.Character.female
        case .genderless: return Localization.Character.genderless
        case .unknown: return Localization.Character.unknown
        }
    }
}

// MARK: - From CharacterGender to CharacterFilterGender

extension CharacterFilterGender {
    init(from gender: CharacterGender?) {
        guard let gender = gender else {
            self = .none
            return
        }
        
        switch gender {
        case .male: self = .male
        case .female: self = .female
        case .genderless: self = .genderless
        case .unknown: self = .unknown
        }
    }
    
    var toCharacterGender: CharacterGender? {
        switch self {
        case .none: return nil
        case .male: return .male
        case .female: return .female
        case .genderless: return .genderless
        case .unknown: return .unknown
        }
    }
}
