import ApplicationCore
import CharacterFeature

public final class ApplicationCoordinator<ApplicationParentCoordinator: ApplicationParentCoordinatorProtocol>: Coordinator<ApplicationParentCoordinator> {
    
    // MARK: - Types
    public typealias Module = CharacterModuleProtocol
    
    // MARK: - Properties
    
    private let module: Module

    // MARK: - Initialization
    
    public init(
        parentCoordinator: ApplicationParentCoordinator?,
        module: Module
    ) {
        self.module = module
        
        super.init(parentCoordinator: parentCoordinator)
    }

    // MARK: - Override Methods
    
    public override func start() {
        self.router.setRootWindow()
        self.router.setRootNavigationController()
        
        startChracterCoordinator()
    }
}

// MARK: - Child Coordinator Initialization

private extension ApplicationCoordinator {
    func startChracterCoordinator() {
        print("startChracterCoordinator")
        
        let characterCoordinator = module.makeCharacterCoordinator(parentCoordinator: self)
        self.addChildCoordinator(characterCoordinator)
        
        characterCoordinator.start()
    }
}

// MARK: - CharacterFeature Module Output Implementation

extension ApplicationCoordinator: CharacterParentCoordinatorProtocol {
    
}
