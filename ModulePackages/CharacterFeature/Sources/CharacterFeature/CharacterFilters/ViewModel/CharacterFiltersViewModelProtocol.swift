import Foundation

protocol CharacterFiltersViewModelProtocol: ObservableObject {
    var status: CharacterFilterStatus { get set }
    var gender: CharacterFilterGender { get set }

    func applyFilters()
    func resetFilters()
}
