import UIKit

public protocol RouterProtocol {
    var rootWindow: UIWindow? { get }
    var rootNavigationController: UINavigationController? { get }
    
    func setRootWindow()
    func setRootNavigationController()
    func pushViewController(viewController: UIViewController)
    func presentViewController(viewController: UIViewController)
}
