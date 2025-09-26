import ApplicationCore

public final class ApplicationCoordinator<ApplicationParentCoordinator: ApplicationParentCoordinatorProtocol>: Coordinator<ApplicationParentCoordinator> {

    // MARK: - Initialization
    
    public init(
        parentCoordinator: ApplicationParentCoordinator?
    ) {
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
    }
}
