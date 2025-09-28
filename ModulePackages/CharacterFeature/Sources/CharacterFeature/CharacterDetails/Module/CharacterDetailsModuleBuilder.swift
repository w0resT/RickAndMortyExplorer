import ApplicationCore
import UIKit
import SwiftUI

final class CharacterDetailsModuleBuilder {
    static func build(
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

        hostingController.title = "Character Details"
        hostingController.navigationItem.largeTitleDisplayMode = .never

        return hostingController
    }
}
