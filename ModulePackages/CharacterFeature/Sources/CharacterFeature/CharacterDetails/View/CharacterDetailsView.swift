import SwiftUI

struct CharacterDetailsView<ViewModel: CharacterDetailsViewModelProtocol>: View {
    
    // MARK: - Private Properties
    
    @ObservedObject private var viewModel: ViewModel

    // MARK: - Initialization
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body Implementation
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ZStack(alignment: .bottom) {
                    AsyncImage(url: URL(string: viewModel.details.imageURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .padding(.top, 6)
                    
                    HStack(spacing: 6) {
                        Circle()
                            .fill(statusColor(viewModel.details.status))
                            .frame(width: 10, height: 10)
                        
                        Text("\(viewModel.details.status)")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 20)
                    .background(Color.black.opacity(0.75))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(10)
                }
    
                Divider().padding(.vertical, 4)
                
                Text(viewModel.details.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("\(viewModel.details.species) - \(viewModel.details.gender)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Divider().padding(.vertical, 4)
                
                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {
                    Text("Origin")
                        .font(.headline)
                    
                    Text(viewModel.details.origin)
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                
                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {
                    Text("Last known location")
                        .font(.headline)
                    
                    Text(viewModel.details.location)
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                
                Spacer()
            }
            .padding(.horizontal, 12)
        }
    }
    
    // MARK: - Methods
    
    // temp
    private func statusColor(_ status: String) -> Color {
        switch status {
        case "alive": return .green
        case "dead": return .red
        default: return .gray
        }
    }
}

#if DEBUG
#Preview {
    CharacterDetailsView(viewModel: MockCharacterDetailsViewModel())
}
#endif
