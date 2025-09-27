import UIKit

public protocol RouterProtocol {
    func setRootWindow()
    func setRootNavigationController()
    func pushViewController(viewController: UIViewController)
    func presentViewController(viewController: UIViewController)
}
