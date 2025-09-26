public typealias Services = HasCharacterService

public protocol HasCharacterService {
    var characterService: CharacterServiceProtocol { get }
}
