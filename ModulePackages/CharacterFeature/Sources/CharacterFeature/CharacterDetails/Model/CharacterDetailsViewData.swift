import Foundation

struct CharacterDetailsViewData {
    let id: Int
    let name: String
    let status: CharacterDetailsStatus
    let species: String
    let gender: String
    let origin: String
    let location: String
    var imageData: Data?
}

extension CharacterDetailsViewData {
    init(character: Character) {
        self.id = character.id
        self.name = character.name
        self.status =  .init(from: character.status)
        self.species = character.species
        self.gender = character.gender.title
        self.origin = character.origin.name
        self.location = character.location.name
        self.imageData = nil
    }
}
