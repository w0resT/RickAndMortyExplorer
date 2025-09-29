import UIKit
import ApplicationCore

// swiftlint:disable:next generic_type_name line_length
public final class CharacterDetailsCoordinator<CharacterDetatailsParentCoordinator: CharacterDetailsParentCoordinatorProtocol>:
    Coordinator<CharacterDetatailsParentCoordinator> {
    
    // MARK: - Properties
    
    private let services: DetailsModuleServices
    private var navigationDelegate: UINavigationControllerDelegate?
    
    // MARK: - Initialization
    
    internal init(
        parentCoordinator: CharacterDetatailsParentCoordinator,
        services: DetailsModuleServices
    ) {
        self.services = services
        
        super.init(parentCoordinator: parentCoordinator)
    }
    
    // MARK: - Methods
    
    public override func start() { }
    
    public func showCharacterDetails(character: Character) {
        let initialData = CharacterDetailsInitialData(character: character)
        let viewController = CharacterDetailsModuleBuilder.build(
            navigationOutput: self,
            services: services,
            initialData: initialData
        )
        
        self.navigationDelegate = CharacterDetailsNavigationDelegate()
        self.router.rootNavigationController?.delegate = self.navigationDelegate
        self.router.pushViewController(viewController: viewController)
    }
}

// MARK: - CharacterDetailsNavigationListenerOutputProtocol

extension CharacterDetailsCoordinator: CharacterDetailsNavigationListenerOutputProtocol {
    public func viewControllerDidDisappear() {
        self.parentCoordinator?.childCoordinatorDidDisappear(self)
    }
}
