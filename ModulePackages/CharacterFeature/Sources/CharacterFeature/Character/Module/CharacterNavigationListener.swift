import ApplicationCore

public final class CharacterNavigationListener: NavigationListenerProtocol {
    
    // MARK: - Properties
    
    private weak var output: CharacterNavigationListenerOutputProtocol?
    
    // MARK: - Initialization
    
    public init(output: CharacterNavigationListenerOutputProtocol?) {
        self.output = output
    }
    
    // MARK: - NavigationListenerProtocol Methods
    
    public func viewControllerDidDisappear() {
        output?.viewControllerDidDisappear()
    }
}

