import SwiftUI

struct CharacterFiltersView<ViewModel: CharacterFiltersViewModelProtocol>: View {
    
    // MARK: - Private Properties
    
    @ObservedObject private var viewModel: ViewModel

    // MARK: - Initialization
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body Implementation
    
    var body: some View {
        VStack {
            HStack {
                Button("Reset") {
                    viewModel.resetFilters()
                }
                .padding()
                
                Spacer()
                
                Button("Apply") {
                    viewModel.applyFilters()
                }
                .padding()
            }
            .padding(.horizontal, 15)
            .padding(.top, 3)
            
            Form {
                Section("Filters") {
                    Picker("Character status", selection: $viewModel.status) {
                        ForEach(CharacterFilterStatus.allCases, id: \.self) {
                            Text($0.title)
                        }
                    }
                    
                    Picker("Character gender", selection: $viewModel.gender) {
                        ForEach(CharacterFilterGender.allCases, id: \.self) {
                            Text($0.title)
                        }
                    }
                }
            }
            .scrollDisabled(true)
        }
        .background(Color.primary.opacity(0.1))
    }
}

#if DEBUG
#Preview {
    CharacterFiltersView(viewModel: MockCharacterFiltersViewModel())
}
#endif
