protocol CharactersViewModelInputProtocol {
    func loadMoreCharacters()
    func loadImage(for character: Character)
    
    func didSelectCharacter(_ character: Character)
    func didTapFilters()
}
