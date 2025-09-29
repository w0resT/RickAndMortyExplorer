// swiftlint:disable generic_type_name

import ApplicationCore
import Services

public typealias CharacterModuleServices = HasCharacterService
    & HasImageLoader

public protocol CharacterModuleProtocol: AnyObject {
    func makeCharacterCoordinator<CharacterParentCoordinator>(
        parentCoordinator: CharacterParentCoordinator
    ) -> CharacterCoordinator<CharacterParentCoordinator>
}

extension CoordinatorFactory: CharacterModuleProtocol {
    public func makeCharacterCoordinator<CharacterParentCoordinator>(
        parentCoordinator: CharacterParentCoordinator
    ) -> CharacterCoordinator<CharacterParentCoordinator> {
        return CharacterCoordinator(
            parentCoordinator: parentCoordinator,
            services: services,
            module: self
        )
    }
}
