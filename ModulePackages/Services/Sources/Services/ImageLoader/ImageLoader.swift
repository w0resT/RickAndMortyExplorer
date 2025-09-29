import Foundation

public protocol ImageLoaderProtocol: AnyObject {
    func fetchImage(_ urlString: String) async throws -> Data
}

// MARK: - ImageLoaderProtocol Implementation

public actor ImageLoader: ImageLoaderProtocol {
    
    // MARK: - Properties
    
    private let networkClient: NetworkClientProtocol
    
    private var dataCache = NSCache<NSString, NSData>()
    private var tasks: [URLRequest: Task<Data, Error>] = [:]
    
    // MARK: - Properties
    
    public init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    // MARK: - ImageLoaderProtocol Methods
    
    public func fetchImage(_ urlString: String) async throws -> Data {
        if let imageCacheData = dataCache.object(forKey: urlString as NSString) {
            return imageCacheData as Data
        }
        
        guard let urlRequest = URL(string: urlString) else {
            throw ImageLoaderError.invalidURL
        }
        
        let request = URLRequest(url: urlRequest)
        if let task = tasks[request] {
            return try await task.value
        }
        
        let imageEndpoint = ImageEndpoint(urlString)
        let task = Task {
            let data = try await networkClient.request(imageEndpoint)
            return data
        }
        
        tasks[request] = task
        defer { tasks[request] = nil }
        
        let imageData = try await task.value
        dataCache.setObject(
            imageData as NSData,
            forKey: urlString as NSString
        )
        
        return imageData
    }
}
