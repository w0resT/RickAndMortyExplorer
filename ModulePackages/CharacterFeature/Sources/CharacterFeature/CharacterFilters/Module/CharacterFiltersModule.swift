import ApplicationCore

public protocol CharacterFiltersModuleProtocol: AnyObject {
    func makeCharacterFiltersCoordinator<CharacterFiltersParentCoordinator>(
        parentCoordinator: CharacterFiltersParentCoordinator
    ) -> CharacterFiltersCoordinator<CharacterFiltersParentCoordinator>
}

extension CoordinatorFactory: CharacterFiltersModuleProtocol {
    public func makeCharacterFiltersCoordinator<CharacterFiltersParentCoordinator>(
        parentCoordinator: CharacterFiltersParentCoordinator
    ) -> CharacterFiltersCoordinator<CharacterFiltersParentCoordinator>{
        return CharacterFiltersCoordinator(
            parentCoordinator: parentCoordinator
        )
    }
}
