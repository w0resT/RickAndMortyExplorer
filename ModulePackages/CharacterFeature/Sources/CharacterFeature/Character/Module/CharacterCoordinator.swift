import ApplicationCore

public final class CharacterCoordinator<CharacterParentCoordinator: CharacterParentCoordinatorProtocol>: Coordinator<CharacterParentCoordinator> {
    
    // MARK: - Types
    public typealias Module = CharacterDetailsModuleProtocol
    
    // MARK: - Properties
    private let services: ModuleServices
    private let module: Module
    
    // MARK: - Initialization
    
    internal init(
        parentCoordinator: CharacterParentCoordinator,
        services: ModuleServices,
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
        let viewController = CharacterModuleBuilder.build(moduleOutput: self)
        
        self.router.pushViewController(viewController: viewController)
    }
}

// MARK: - Character Module Output

extension CharacterCoordinator: CharacterModuleOutputProtocol {
    func showCharacterDetails(character: Character) {
        let detailsCoordinator = module.makeCharacterDetailsCoordinator(parentCoordinator: self)
        detailsCoordinator.start()
        detailsCoordinator.showCharacterDetails(character: character)
    }
}

// MARK: - CharacterDetails Module Output

extension CharacterCoordinator: CharacterDetailsParentCoordinator {
    
}
