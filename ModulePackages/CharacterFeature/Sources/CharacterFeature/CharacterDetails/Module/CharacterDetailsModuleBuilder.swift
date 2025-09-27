import UIKit
import SwiftUI

final class CharacterDetailsModuleBuilder {
    static func build(initialData: CharacterDetailsInitialData) -> UIViewController {
        let viewModel = CharacterDetailsViewModel(initialData: initialData)
        let view = CharacterDetailsView(viewModel: viewModel)

        let hostingController = UIHostingController(rootView: view)
        hostingController.title = "Character Details"
        hostingController.navigationItem.largeTitleDisplayMode = .never

        return hostingController
    }
}
