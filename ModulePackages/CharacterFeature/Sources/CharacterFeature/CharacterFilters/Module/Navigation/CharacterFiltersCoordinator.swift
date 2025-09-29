import ApplicationCore

// swiftlint:disable:next generic_type_name line_length
public final class CharacterFiltersCoordinator<CharacterFiltersParentCoordinator: CharacterFiltersParentCoordinatorProtocol>:
    Coordinator<CharacterFiltersParentCoordinator> {
    
    // MARK: - Methods
    
    public override func start() { }
    
    public func showCharacterFilters(currentFilters: CharacterFilters) {
        let initialData = CharacterFiltersInitialData(filters: currentFilters)
        let viewController = CharacterFiltersModuleBuilder.build(
            moduleOutput: self,
            navigationOutput: self,
            initialData: initialData
        )
        
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        
        self.router.presentViewController(viewController: viewController)
    }
}

// MARK: - CharacterFiltersNavigationListenerOutputProtocol

extension CharacterFiltersCoordinator: CharacterFiltersNavigationListenerOutputProtocol {
    public func viewControllerDidDisappear() {
        self.parentCoordinator?.childCoordinatorDidDisappear(self)
    }
}

// MARK: - CharacterFilters Module Output

extension CharacterFiltersCoordinator: CharacterFiltersModuleOutputProtocol {
    public func applyFilters(_ filters: CharacterFilters) {
        self.parentCoordinator?.applyFilters(filters: filters)
    }
}
