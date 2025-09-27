public final class ServiceContainer: Services {
    
    // MARK: - Properties
    
    public var characterService: CharacterServiceProtocol
    
    // MARK: - Initialization
    
    public init(
        characterService: CharacterServiceProtocol
    ) {
        self.characterService = characterService
    }
    
    public convenience init() {
        let characterService = CharacterService()
        
        self.init(
            characterService: characterService
        )
    }
}
