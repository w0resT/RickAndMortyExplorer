import ApplicationCore

public protocol CharacterDetailsModuleProtocol: AnyObject {
    func makeCharacterDetailsCoordinator<CharacterDetailsParentCoordinator>(
        parentCoordinator: CharacterDetailsParentCoordinator
    ) -> CharacterDetailsCoordinator<CharacterDetailsParentCoordinator>
}

extension CoordinatorFactory: CharacterDetailsModuleProtocol {
    public func makeCharacterDetailsCoordinator<CharacterDetailsParentCoordinator>(
        parentCoordinator: CharacterDetailsParentCoordinator
    ) -> CharacterDetailsCoordinator<CharacterDetailsParentCoordinator>{
        return CharacterDetailsCoordinator(
            parentCoordinator: parentCoordinator
        )
    }
}
