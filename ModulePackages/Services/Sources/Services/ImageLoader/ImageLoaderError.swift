import Foundation

public enum ImageLoaderError: LocalizedError {
    case invalidURL
}

extension ImageLoaderError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        }
    }
}
