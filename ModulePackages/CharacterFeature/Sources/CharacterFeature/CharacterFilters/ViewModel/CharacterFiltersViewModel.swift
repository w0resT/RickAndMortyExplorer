import Foundation

protocol CharacterFiltersViewModelProtocol: ObservableObject {
    var status: CharacterFilterStatus { get set }
    var gender: CharacterFilterGender { get set }
}

// MARK: - CharacterFiltersViewModelProtocol Implementation

final class CharacterFiltersViewModel: CharacterFiltersViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var status: CharacterFilterStatus
    @Published var gender: CharacterFilterGender
    
    private weak var moduleOutput: CharacterFiltersModuleOutputProtocol?
    
    // MARK: - Initialization
    
    init(
        moduleOutput: CharacterFiltersModuleOutputProtocol?,
        initialData: CharacterFiltersInitialData
    ) {
        self.moduleOutput = moduleOutput
        
        self.status = .init(from: initialData.filters.status)
        self.gender = .init(from: initialData.filters.gender)
    }
}

// MARK: - CharacterFiltersViewModelInputProtocol

extension CharacterFiltersViewModel: CharacterFiltersViewModelInputProtocol {
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
