public final class ServiceContainer: Services {
    
    // MARK: - Properties
    
    public var networkClient: NetworkClientProtocol
    public var characterService: CharacterServiceProtocol
    public var imageLoader: ImageLoaderProtocol
    
    // MARK: - Initialization
    
    public init(
        networkClient: NetworkClientProtocol,
        characterService: CharacterServiceProtocol,
        imageLoader: ImageLoaderProtocol
    ) {
        self.networkClient = networkClient
        self.characterService = characterService
        self.imageLoader = imageLoader
    }
    
    public convenience init() {
        let networkClient = NetworkClient(urlSession: .shared)
        let characterService = CharacterService(networkClient: networkClient)
        let imageLoader = ImageLoader(networkClient: networkClient)
        
        self.init(
            networkClient: networkClient,
            characterService: characterService,
            imageLoader: imageLoader
        )
    }
}
