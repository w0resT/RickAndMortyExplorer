import SwiftUI
import ApplicationResources

struct CharacterFiltersSectionFiltersView: View {
    
    // MARK: - Properties
    
    @Binding private var status: CharacterFilterStatus
    @Binding private var gender: CharacterFilterGender
    
    // MARK: - Initialization
    
    init(
        status: Binding<CharacterFilterStatus>,
        gender: Binding<CharacterFilterGender>
    ) {
        self._status = status
        self._gender = gender
    }
    
    // MARK: - Body Implementation
    
    var body: some View {
        Section(Localization.CharacterFilters.Section.filters) {
            characterStatus
            characterGender
        }
    }
    
    // MARK: - Private
    
    private var characterStatus: some View {
        Picker(Localization.CharacterFilters.status, selection: $status) {
            ForEach(CharacterFilterStatus.allCases, id: \.self) {
                Text($0.title)
            }
        }
    }
    
    private var characterGender: some View {
        Picker(Localization.CharacterFilters.gender, selection: $gender) {
            ForEach(CharacterFilterGender.allCases, id: \.self) {
                Text($0.title)
            }
        }
    }
}

#if DEBUG
#Preview {
    Form {
        CharacterFiltersSectionFiltersView(
            status: .constant(.alive),
            gender: .constant(.male)
        )
    }
}
#endif
