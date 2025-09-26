import ApplicationCore

public protocol ApplicationModuleProtocol: AnyObject {
    func makeApplicationCoordinator<ApplicationParentCoordinator>(
        parentCoordinator: ApplicationParentCoordinator?
    ) -> ApplicationCoordinator<ApplicationParentCoordinator>
}

extension CoordinatorFactory: ApplicationModuleProtocol {
    public func makeApplicationCoordinator<ApplicationParentCoordinator>(
        parentCoordinator: ApplicationParentCoordinator?
    ) -> ApplicationCoordinator<ApplicationParentCoordinator> {
        return ApplicationCoordinator(
            parentCoordinator: parentCoordinator
        )
    }
}
