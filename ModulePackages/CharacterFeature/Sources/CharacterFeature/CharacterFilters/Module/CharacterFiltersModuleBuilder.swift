import UIKit
import SwiftUI
import ApplicationCore
import ApplicationResources

internal final class CharacterFiltersModuleBuilder {
    internal static func build(
        moduleOutput: CharacterFiltersModuleOutputProtocol?,
        navigationOutput: CharacterFiltersNavigationListenerOutputProtocol?,
        initialData: CharacterFiltersInitialData
    ) -> UIViewController {
        let viewModel = CharacterFiltersViewModel(
            moduleOutput: moduleOutput,
            initialData: initialData
        )
        let view = CharacterFiltersView(viewModel: viewModel)
        
        let navigationListener = CharacterFiltersNavigationListener(output: navigationOutput)
        let hostingController = HostingController(rootView: view)
        hostingController.navigationListener = navigationListener

        hostingController.title = Localization.CharacterFilters.title
        hostingController.navigationItem.largeTitleDisplayMode = .never
        hostingController.sheetPresentationController?.delegate = navigationListener

        return hostingController
    }
}
