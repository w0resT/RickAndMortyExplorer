public struct CharacterDetailsViewData {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: String
    let location: String
    let imageURL: String
}

extension CharacterDetailsViewData {
    init(character: Character) {
        self.id = character.id
        self.name = character.name
        self.status = character.status.rawValue
        self.species = character.species
        self.gender = character.gender.rawValue
        self.origin = character.origin.name
        self.location = character.location.name
        self.imageURL = character.image
    }
}
