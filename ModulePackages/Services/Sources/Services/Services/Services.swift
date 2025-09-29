public typealias Services = HasNetworkClient
    & HasCharacterService
    & HasImageLoader

public protocol HasNetworkClient {
    var networkClient: NetworkClientProtocol { get }
}

public protocol HasCharacterService {
    var characterService: CharacterServiceProtocol { get }
}

public protocol HasImageLoader {
    var imageLoader: ImageLoaderProtocol { get }
}
