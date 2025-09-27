import UIKit
import ApplicationCore

public final class CharacterFiltersNavigationListener: NSObject, NavigationListenerProtocol {
    
    // MARK: - Properties
    
    private weak var output: CharacterFiltersNavigationListenerOutputProtocol?
    
    // MARK: - Initialization
    
    public init(output: CharacterFiltersNavigationListenerOutputProtocol?) {
        self.output = output
    }
    
    // MARK: - Methods
    
    public func viewControllerDidDisappear() {
        output?.viewControllerDidDisappear()
    }
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        output?.viewControllerDidDisappear()
    }
}
