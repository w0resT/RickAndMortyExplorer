import UIKit
import ApplicationCore

public final class CharacterDetailsNavigationListener: NSObject, NavigationListenerProtocol {
    
    // MARK: - Properties
    
    private weak var output: CharacterDetailsNavigationListenerOutputProtocol?
    
    // MARK: - Initialization
    
    public init(output: CharacterDetailsNavigationListenerOutputProtocol?) {
        self.output = output
    }
    
    // MARK: - NavigationListenerProtocol Methods
    
    public func viewControllerDidDisappear() {
        output?.viewControllerDidDisappear()
    }
}
