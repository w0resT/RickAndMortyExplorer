import Foundation

internal enum CharacterFilterParameters: String {
    case name
    case status
    case gender
}

internal struct CharactersEndpoint: EndpointProtocol {
    
    // MARK: - Properties
    
    internal var baseUrl: String
    internal var path: String
    internal var headers: [String : String]
    internal var queryItems: [URLQueryItem]
    internal var method: HTTPMethod
    
    // MARK: - Initialization
    
    internal init(
        nextURL: String?,
        searchQuery: String?,
        filters: CharacterFiltersRequest
    ) {
        if let nextURL {
            self.baseUrl = ""
            self.path = nextURL
        } else {
            self.baseUrl = CharacterServiceConstants.baseURL
            self.path = CharacterServiceConstants.characterPath
        }
        
        self.headers = [:]
        self.method = .get
        
        var queryItems: [URLQueryItem] = []
        if let searchQuery {
            queryItems.append(
                .init(
                    name: CharacterFilterParameters.name.rawValue,
                    value: searchQuery
                )
            )
        }
        
        if let status = filters.status {
            queryItems.append(
                .init(
                    name: CharacterFilterParameters.status.rawValue,
                    value: status
                )
            )
        }
        
        if let gender = filters.gender {
            queryItems.append(
                .init(
                    name: CharacterFilterParameters.gender.rawValue,
                    value: gender
                )
            )
        }
        
        self.queryItems = queryItems
    }
}
