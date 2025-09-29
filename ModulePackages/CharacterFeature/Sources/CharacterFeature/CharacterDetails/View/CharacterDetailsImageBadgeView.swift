import SwiftUI

struct CharacterDetailsImageBadgeView: View {
    
    // MARK: - Properties
    
    private let status: CharacterDetailsStatus
    
    // MARK: - Initialization
    
    init(status: CharacterDetailsStatus) {
        self.status = status
    }
    
    // MARK: - Body Implementation
    
    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(statusColor(status))
                .frame(width: 10, height: 10)
            
            Text("\(status.title)")
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
    
    // MARK: - Methods
    
    private func statusColor(_ status: CharacterDetailsStatus) -> Color {
        switch status {
        case .alive: return .green
        case .dead: return .red
        case .unknown: return .gray
        }
    }
}

#if DEBUG
#Preview {
    CharacterDetailsImageBadgeView(status: .alive)
}
#endif
