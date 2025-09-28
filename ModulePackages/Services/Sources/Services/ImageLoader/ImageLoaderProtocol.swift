import Foundation

public protocol ImageLoaderProtocol: AnyObject {
    func fetchImage(_ urlString: String) async throws -> Data
}
