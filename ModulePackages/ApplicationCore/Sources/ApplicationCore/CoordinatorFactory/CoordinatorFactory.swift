import Services

public final class CoordinatorFactory {
    
    // MARK: - Properties
    
    public let services: Services

    // MARK: - Initialization
    
    public init(services: Services) {
        self.services = services
    }
}
