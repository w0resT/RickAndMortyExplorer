import ApplicationCore

public final class CharacterDetailsCoordinator<CharacterDetatailsParentCoordinator: CharacterDetailsParentCoordinator>: Coordinator<CharacterDetatailsParentCoordinator> {
    
    // MARK: - Initialization
    
    internal init(
        parentCoordinator: CharacterDetatailsParentCoordinator
    ) {
        super.init(parentCoordinator: parentCoordinator)
    }
    
    // MARK: - Methods
    
    public override func start() { }
    
    public func showCharacterDetails(character: Character) {
        let initialData = CharacterDetailsInitialData(character: character)
        let viewController = CharacterDetailsModuleBuilder.build(
            navigationOutput: self,
            initialData: initialData
        )
        
        self.router.pushViewController(viewController: viewController)
    }
}

// MARK: - CharacterDetailsNavigationListenerOutputProtocol

extension CharacterDetailsCoordinator: CharacterDetailsNavigationListenerOutputProtocol {
    public func viewControllerDidDisappear() {
        self.parentCoordinator?.childCoordinatorDidDisappear(self)
    }
}
