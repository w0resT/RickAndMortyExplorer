import UIKit
import SwiftUI
import ApplicationCore
import ApplicationResources

internal final class CharacterDetailsModuleBuilder {
    internal static func build(
        navigationOutput: CharacterDetailsNavigationListenerOutputProtocol?,
        services: DetailsModuleServices,
        initialData: CharacterDetailsInitialData
    ) -> UIViewController {
        let viewModel = CharacterDetailsViewModel(
            services: services,
            initialData: initialData
        )
        let view = CharacterDetailsView(viewModel: viewModel)
        
        let navigationListener = CharacterDetailsNavigationListener(output: navigationOutput)
        let hostingController = HostingController(rootView: view)
        hostingController.navigationListener = navigationListener

        hostingController.title = Localization.CharacterDetails.title
        hostingController.navigationItem.largeTitleDisplayMode = .never

        return hostingController
    }
}
