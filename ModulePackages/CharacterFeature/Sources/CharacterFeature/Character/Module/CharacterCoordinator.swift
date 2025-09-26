import ApplicationCore

public final class CharacterCoordinator<CharacterParentCoordinator: CharacterParentCoordinatorProtocol>: Coordinator<CharacterParentCoordinator> {
    
    // MARK: - Initialization
    
    internal init(
        parentCoordinator: CharacterParentCoordinator
    ) {
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
