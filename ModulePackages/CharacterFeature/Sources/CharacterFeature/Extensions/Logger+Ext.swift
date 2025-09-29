import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    private enum Category: String {
        case characters
        case characterDetails
    }
    
    static let characters = Logger(
        subsystem: subsystem,
        category: Category.characters.rawValue
    )
    
    static let characterDetails = Logger(
        subsystem: subsystem,
        category: Category.characterDetails.rawValue
    )
}
