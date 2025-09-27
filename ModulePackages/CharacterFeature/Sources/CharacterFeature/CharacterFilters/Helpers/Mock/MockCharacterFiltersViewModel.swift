import Foundation

final class MockCharacterFiltersViewModel: CharacterFiltersViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var status: CharacterFilterStatus = .none
    @Published var gender: CharacterFilterGender = .none
    
    // MARK: - Methods
    
    func applyFilters() { }
    func resetFilters() { }
}
