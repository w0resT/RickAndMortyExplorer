import ApplicationCore

public final class CharacterCoordinator<CharacterParentCoordinator: CharacterParentCoordinatorProtocol>: Coordinator<CharacterParentCoordinator> {
    
    // MARK: - Properties
    private let services: ModuleServices
    
    // MARK: - Initialization
    
    internal init(
        parentCoordinator: CharacterParentCoordinator,
        services: ModuleServices
    ) {
        self.services = services
        
        super.init(parentCoordinator: parentCoordinator)
    }
    
    // MARK: - Overrides
    
    public override func start() {
        showCharacterList()
    }
}

// MARK: - Module Initialization

private extension CharacterCoordinator {
    func showCharacterList() {
        print("showCharacterList")
    }
}
