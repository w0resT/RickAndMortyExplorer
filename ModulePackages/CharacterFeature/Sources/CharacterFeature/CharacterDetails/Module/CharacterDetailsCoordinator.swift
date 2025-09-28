import ApplicationCore

public final class CharacterDetailsCoordinator<CharacterDetatailsParentCoordinator: CharacterDetailsParentCoordinatorProtocol>: Coordinator<CharacterDetatailsParentCoordinator> {
    
    // MARK: - Properties
    
    private let services: DetailsModuleServices
    
    // MARK: - Initialization
    
    init(
        parentCoordinator: CharacterDetatailsParentCoordinator,
        services: DetailsModuleServices
    ) {
        self.services = services
        
        super.init(parentCoordinator: parentCoordinator)
    }
    
    // MARK: - Methods
    
    public override func start() { }
    
    public func showCharacterDetails(character: Character) {
        let initialData = CharacterDetailsInitialData(character: character)
        let viewController = CharacterDetailsModuleBuilder.build(
            navigationOutput: self,
            services: services,
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
