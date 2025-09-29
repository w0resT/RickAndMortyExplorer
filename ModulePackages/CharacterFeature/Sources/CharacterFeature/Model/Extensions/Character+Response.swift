import Services

// MARK: - From CharacterResponse to Character

public extension Character {
    init(from response: CharacterResponse) {
        self.id = response.id
        self.name = response.name
        self.status = .init(from: response.status)
        self.species = response.species
        self.type = response.type
        self.gender = .init(from: response.gender)
        self.origin = .init(from: response.origin)
        self.location = .init(from: response.location)
        self.image = response.image
        self.episode = response.episode
        self.url = response.url
        self.created = response.created
    }
}

// MARK: - From CharacterStatusResponse to CharacterStatus

public extension CharacterStatus {
    init(from response: CharacterStatusResponse) {
        switch response {
        case .alive: self = .alive
        case .dead: self = .dead
        case .unknown: self = .unknown
        }
    }
}

// MARK: - From CharacterGenderResponse to CharacterGender

public extension CharacterGender {
    init(from response: CharacterGenderResponse) {
        switch response {
        case .male: self = .male
        case .female: self = .female
        case .genderless: self = .genderless
        case .unknown: self = .unknown
        }
    }
}

// MARK: - From CharacterOriginResponse to CharacterOrigin

public extension CharacterOrigin {
    init(from response: CharacterOriginResponse) {
        self.name = response.name
        self.url = response.url
    }
}

// MARK: - From CharacterLocationResponse to CharacterLocation

public extension CharacterLocation {
    init(from response: CharacterLocationResponse) {
        self.name = response.name
        self.url = response.url
    }
}
