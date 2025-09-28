import Foundation

struct ImageEndpoint: EndpointProtocol {
    var baseUrl: String
    var path: String
    var headers: [String : String]
    var queryItems: [URLQueryItem]
    var method: HTTPMethod
    
    init(_ urlString: String) {
        self.baseUrl = ""
        self.path = urlString
        self.headers = [:]
        self.queryItems = []
        self.method = .get
    }
}
