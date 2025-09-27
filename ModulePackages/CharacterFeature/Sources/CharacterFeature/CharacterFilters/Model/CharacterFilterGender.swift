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
        case .none:
            return "None"
        case .male:
            return "Male"
        case .female:
            return "Female"
        case .genderless:
            return "Genderless"
        case .unknown:
            return "Unknown"
        }
    }
}

extension CharacterFilterGender {
    init(from gender: CharacterGender?) {
        guard let gender = gender else {
            self = .none
            return
        }
        
        switch gender {
        case .male:
            self = .male
        case .female:
            self = .female
        case .genderless:
            self = .genderless
        case .unknown:
            self = .unknown
        }
    }
    
    var toCharacterGender: CharacterGender? {
        switch self {
        case .none:
            return nil
        case .male:
            return .male
        case .female:
            return .female
        case .genderless:
            return .genderless
        case .unknown:
            return .unknown
        }
    }
}
