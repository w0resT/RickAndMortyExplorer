import Foundation

final class CharacterFiltersViewModel: CharacterFiltersViewModelProtocol {
    
    // MARK: - Properties
    
    private weak var moduleOutput: CharacterFiltersModuleOutputProtocol?
    
    @Published var status: CharacterFilterStatus
    @Published var gender: CharacterFilterGender
    
    // MARK: - Initialization
    
    init(
        moduleOutput: CharacterFiltersModuleOutputProtocol?,
        initialData: CharacterFiltersInitialData
    ) {
        self.moduleOutput = moduleOutput
        
        self.status = .init(from: initialData.filters.status)
        self.gender = .init(from: initialData.filters.gender)
    }
    
    // MARK: - Methods
    
    func applyFilters() {
        let filters = CharacterFilters(
            status: status.toCharacterStatus,
            gender: gender.toCharacterGender
        )

        self.moduleOutput?.applyFilters(filters)
    }
    
    func resetFilters() {
        status = .none
        gender = .none
    }
}
