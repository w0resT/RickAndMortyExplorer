public final class ServiceContainer: Services {
    
    // MARK: - Properties
    
    public var networkClient: NetworkClientProtocol
    public var characterService: CharacterServiceProtocol
    
    // MARK: - Initialization
    
    public init(
        networkClient: NetworkClientProtocol,
        characterService: CharacterServiceProtocol
    ) {
        self.networkClient = networkClient
        self.characterService = characterService
    }
    
    public convenience init() {
        let networkClient = NetworkClient(urlSession: .shared)
        let characterService = CharacterService(networkClient: networkClient)
        
        self.init(
            networkClient: networkClient,
            characterService: characterService
        )
    }
}
