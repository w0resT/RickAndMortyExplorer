import UIKit
import ApplicationCore
import ApplicationModule

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    
    private var applicationCoordinator: ApplicationCoordinator<AppDelegate>?

    // MARK: - Application Lifecycle
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let coordinatorFactory = CoordinatorFactory()
        applicationCoordinator = coordinatorFactory.makeApplicationCoordinator(parentCoordinator: self)
        applicationCoordinator?.start()
        
        return true
    }
}

// MARK: - ApplicationParentCoordinatorProtocol

extension AppDelegate: ApplicationParentCoordinatorProtocol {
    func childCoordinatorDidDisappear(_ coordinator: CoordinatorProtocol) { }
}
