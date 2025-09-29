import UIKit

public final class Router: RouterProtocol {
    
    // MARK: - Singleton
    
    static public let shared: Router = Router()

    // MARK: - Properties
    
    public var rootWindow: UIWindow?
    public var rootNavigationController: UINavigationController?

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

    public func presentViewController(viewController: UIViewController) {
        self.rootNavigationController?.viewControllers.last?.present(viewController, animated: true)
    }
}
