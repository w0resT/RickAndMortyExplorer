import UIKit

final class CharacterModuleBuilder {
    static func build(
        moduleOutput: CharacterModuleOutputProtocol?,
        navigationOutput: CharacterNavigationListenerOutputProtocol?,
        services: CharacterModuleServices
    ) -> (UIViewController, CharacterModuleInputProtocol) {
        let viewModel = CharactersViewModel(
            moduleOutput: moduleOutput,
            services: services
        )
        
        let navigationListener = CharacterNavigationListener(output: navigationOutput)
        let viewController = CharactersViewController(
            navigationOutput: navigationListener,
            viewModel: viewModel
        )
        
        return (viewController, viewModel)
    }
}
