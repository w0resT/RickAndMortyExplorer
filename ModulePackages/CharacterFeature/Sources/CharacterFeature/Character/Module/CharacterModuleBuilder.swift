import UIKit

final class CharacterModuleBuilder {
    static func build(
        moduleOutput: CharacterModuleOutputProtocol?
    ) -> UIViewController {
        let viewModel = CharactersViewModel(moduleOutput: moduleOutput)
        let viewController = CharactersViewController(viewModel: viewModel)
        
        return viewController
    }
}
