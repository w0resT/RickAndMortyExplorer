import Foundation

protocol CharacterDetailsViewModelProtocol: ObservableObject {
    var details: CharacterDetailsViewData { get }
    var loadingState: CharactersDetailsLoadingState { get }
}
