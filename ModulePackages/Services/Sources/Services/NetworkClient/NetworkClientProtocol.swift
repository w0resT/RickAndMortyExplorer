import Foundation

public protocol NetworkClientProtocol {
    func request(_ endpoint: EndpointProtocol) async throws -> Data
    func request<T: Decodable>(_ endpoint: EndpointProtocol) async throws -> T
}
