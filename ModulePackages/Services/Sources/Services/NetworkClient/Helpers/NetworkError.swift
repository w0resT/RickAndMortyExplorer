import Foundation

public enum NetworkError: LocalizedError, Equatable {
    case invalidUrl
    case invalidResponse
    case badServerResponse(Int)
}

extension NetworkError {
    public var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .invalidResponse:
            return "Error converting to HTTPURLResponse"
        case .badServerResponse(let statusCode):
            return "Bad response from the server, code: \(statusCode)"
        }
    }
}
