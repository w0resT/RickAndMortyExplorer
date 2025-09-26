open class Coordinator<ParentCoordinator: ParentCoordinatorProtocol>: CoordinatorProtocol {
    
    // MARK: - Properties
    
    public var router: RouterProtocol
    public var childCoordinators: [CoordinatorProtocol] = []
    public weak var parentCoordinator: ParentCoordinator?

    // MARK: - Initialization
    
    public init(
        router: RouterProtocol = Router.shared,
        parentCoordinator: ParentCoordinator?
    ) {
        self.router = router
        self.parentCoordinator = parentCoordinator
    }

    // MARK: - Coordinator Open Methods
    
    open func start() {
        assertionFailure("Метод не переопределён!")
    }

    open func finish() {
        childCoordinators.forEach { $0.finish() }
        childCoordinators.removeAll()
    }

    // MARK: - Coordinator Public Methods
    
    public func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        for childCoordinator in childCoordinators where childCoordinator === coordinator {
            assertionFailure("Повторное добавление дочернего координатора!")
            return
        }

        childCoordinators.append(coordinator)
    }

    public func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.removeAll { childCoordinator in
            return childCoordinator === coordinator
        }
    }
}

