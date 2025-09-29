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
        
        let status = character.status.title
        let species = character.species
        let gender = character.gender.title
        self.statusSpeciesGender = "\(status) - \(species) - \(gender)"
        
        self.locationName = character.location.name
        self.imageURL = character.image
    }
}
