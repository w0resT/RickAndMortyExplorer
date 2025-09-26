import UIKit

public final class Router: RouterProtocol {
    // MARK: - Singleton
    
    static public let shared: Router = Router()

    // MARK: - Properties
    
    private var rootWindow: UIWindow?
    private var rootNavigationController: UINavigationController?

    // MARK: - RouterProtocol Methods
    
    public func setRootWindow() {
        self.rootWindow = UIWindow(frame: UIScreen.main.bounds)
        self.rootWindow?.makeKeyAndVisible()
    }

    public func setRootNavigationController() {
        self.rootNavigationController = UINavigationController()
        self.rootWindow?.rootViewController = self.rootNavigationController
    }

    public func pushViewController(viewController: UIViewController) {
        self.rootNavigationController?.pushViewController(viewController, animated: true)
    }
}
