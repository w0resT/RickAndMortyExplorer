import SwiftUI

public class HostingController<Content: View>: UIHostingController<Content> {
    
    // MARK: - Properties
    
    public var navigationListener: NavigationListenerProtocol?

    // MARK: - Lifecycle
    
    public override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)

        if parent == nil {
            navigationListener?.viewControllerDidDisappear()
        }
    }
}
