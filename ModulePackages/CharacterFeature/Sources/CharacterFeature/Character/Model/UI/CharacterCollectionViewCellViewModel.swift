struct CharacterCollectionViewCellViewModel {
    let id: Int
    let name: String
    let statusSpeciesGender: String
    let locationName: String
    let imageURL: String
}

extension CharacterCollectionViewCellViewModel {
    init(character: Character) {
        self.id = character.id
        self.name = character.name
        self.statusSpeciesGender = "\(character.status.rawValue) - \(character.species) - \(character.gender.rawValue)"
        self.locationName = character.location.name
        self.imageURL = character.image
    }
}
