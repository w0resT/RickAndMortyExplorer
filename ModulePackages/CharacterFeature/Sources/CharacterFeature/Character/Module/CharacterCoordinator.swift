import ApplicationCore

public final class CharacterCoordinator<CharacterParentCoordinator: CharacterParentCoordinatorProtocol>: Coordinator<CharacterParentCoordinator> {
    
    // MARK: - Types
    public typealias Module = CharacterDetailsModuleProtocol
        & CharacterFiltersModuleProtocol
    
    // MARK: - Properties
    private let services: CharacterModuleServices
    private let module: Module
    
    private weak var moduleInput: CharacterModuleInputProtocol?
    
    // MARK: - Initialization
    
    internal init(
        parentCoordinator: CharacterParentCoordinator,
        services: CharacterModuleServices,
        module: Module
    ) {
        self.services = services
        self.module = module
        
        super.init(parentCoordinator: parentCoordinator)
    }
    
    // MARK: - Methods
    
    public override func start() {
        showCharactersList()
    }
}

// MARK: - Module Initialization

private extension CharacterCoordinator {
    func showCharactersList() {
        let (viewController, viewModel) = CharacterModuleBuilder.build(
            moduleOutput: self,
            navigationOutput: self,
            services: services
        )
        
        self.moduleInput = viewModel
        
        self.router.pushViewController(viewController: viewController)
    }
}

// MARK: - Character Module Output

extension CharacterCoordinator: CharacterModuleOutputProtocol {
    func showCharacterDetails(character: Character) {
        let detailsCoordinator = module.makeCharacterDetailsCoordinator(parentCoordinator: self)
        self.addChildCoordinator(detailsCoordinator)
        
        detailsCoordinator.start()
        detailsCoordinator.showCharacterDetails(character: character)
    }
    
    func showCharacterFilters(filters: CharacterFilters) {
        let filtersCoordinator = module.makeCharacterFiltersCoordinator(parentCoordinator: self)
        self.addChildCoordinator(filtersCoordinator)
        
        filtersCoordinator.start()
        filtersCoordinator.showCharacterFilters(currentFilters: filters)
    }
}

// MARK: - Character Module Navigation Output

extension CharacterCoordinator: CharacterNavigationListenerOutputProtocol {
    public func viewControllerDidDisappear() {
        self.parentCoordinator?.childCoordinatorDidDisappear(self)
    }
}

// MARK: - Character Childs Coordinators Module Output

extension CharacterCoordinator: CharacterDetailsParentCoordinatorProtocol, CharacterFiltersParentCoordinatorProtocol {
    public func childCoordinatorDidDisappear(_ coordinator: CoordinatorProtocol) {
        coordinator.finish()
        self.removeChildCoordinator(coordinator)
    }
    
    public func applyFilters(filters: CharacterFilters) {
        self.moduleInput?.applyFilters(filters: filters)
    }
}
