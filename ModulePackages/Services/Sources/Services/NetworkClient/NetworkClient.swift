import Foundation

public protocol NetworkClientProtocol {
    func request(_ endpoint: EndpointProtocol) async throws -> Data
    func request<T: Decodable>(_ endpoint: EndpointProtocol) async throws -> T
}

// MARK: - NetworkClientProtocol Implementation

public class NetworkClient: NetworkClientProtocol {
    
    // MARK: - Private Properties
    
    private let urlSession: URLSession
    private let decoder: JSONDecoder

    // MARK: - Initialization
    
    public init(
        urlSession: URLSession,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.urlSession = urlSession
        self.decoder = decoder
    }

    // MARK: - NetworkClientProtocol Methods
    
    public func request(_ endpoint: any EndpointProtocol) async throws -> Data {
        guard let endpointURL = endpoint.url else {
            throw NetworkError.invalidUrl
        }

        var request = URLRequest(url: endpointURL)
        request.httpMethod = endpoint.method.rawValue
        
        for (key, value) in endpoint.headers {
            request.addValue(value, forHTTPHeaderField: key)
        }

        let (data, response) = try await urlSession.data(for: request)
        try validateResponse(response: response)

        return data
    }

    public func request<T: Decodable>(_ endpoint: any EndpointProtocol) async throws -> T {
        let data = try await self.request(endpoint)
        let decodedData = try decoder.decode(T.self, from: data)

        return decodedData
    }
}

// MARK: - Helpers

private extension NetworkClient {
    func validateResponse(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200..<400).contains(httpResponse.statusCode) else {
            throw NetworkError.badServerResponse(httpResponse.statusCode)
        }
    }
}

