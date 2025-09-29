import Foundation

internal struct ImageEndpoint: EndpointProtocol {
    
    // MARK: - Properties
    
    internal var baseUrl: String
    internal var path: String
    internal var headers: [String : String]
    internal var queryItems: [URLQueryItem]
    internal var method: HTTPMethod
    
    // MARK: - Initialization
    
    internal init(_ urlString: String) {
        self.baseUrl = ""
        self.path = urlString
        self.headers = [:]
        self.queryItems = []
        self.method = .get
    }
}
