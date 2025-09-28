public typealias Services = HasNetworkClient
    & HasCharacterService


public protocol HasNetworkClient {
    var networkClient: NetworkClientProtocol { get }
}

public protocol HasCharacterService {
    var characterService: CharacterServiceProtocol { get }
}
