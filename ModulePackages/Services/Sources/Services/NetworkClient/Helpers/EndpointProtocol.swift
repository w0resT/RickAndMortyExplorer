import Foundation

public protocol EndpointProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem] { get }
    var method: HTTPMethod { get }
}

public extension EndpointProtocol {
    var url: URL? {
        if path.hasPrefix("http") {
            return URL(string: path)
        }
        
        var components = URLComponents(string: baseUrl)
        components?.queryItems = queryItems
        components?.path = path

        guard let finalURL = components?.url,
                finalURL.scheme?.hasPrefix("http") == true else {
            return nil
        }

        return finalURL
    }
}
