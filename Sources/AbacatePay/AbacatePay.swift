import Foundation

public class AbacatePay {
    private let apiKey: String
    private let baseURL = URL(string: "https://api.abacatepay.com/v1")!
    private let version = "1.0.0"
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    private var defaultHeaders: [String: String] {
        [
            "Authorization": "Bearer \(apiKey)",
            "Content-Type": "application/json",
            "User-Agent": "Swift SDK (\(version))",
        ]
    }
    
    public enum AbacatePayError: Error {
        case missingAPIKey
        case networkError(Error)
        case invalidResponse
        case httpError(statusCode: Int, message: String)
    }
    
    internal func request<T: Codable>(
        path: String,
        method: String = "GET",
        body: Data? = nil
    ) async throws -> T {
        guard !apiKey.isEmpty else {
            throw AbacatePayError.missingAPIKey
        }
        
        var request = URLRequest(url: baseURL.appendingPathComponent(path))
        request.httpMethod = method
        request.allHTTPHeaderFields = defaultHeaders
        request.httpBody = body
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw AbacatePayError.invalidResponse
            }
            
            switch httpResponse.statusCode {
                case 200...299:
                    return try JSONDecoder().decode(T.self, from: data)
                default:
                    let errorString = String(data: data, encoding: .utf8) ?? "Unknown error"
                    throw AbacatePayError.httpError(
                        statusCode: httpResponse.statusCode,
                        message: errorString
                    )
            }
        } catch {
            throw AbacatePayError.networkError(error)
        }
    }
    
    public struct Billing {
        private let parent: AbacatePay
        
        internal init(parent: AbacatePay) {
            self.parent = parent
        }
        
        public func create(data: CreateBillingData) async throws -> CreateBillingResponse {
            let jsonData = try JSONEncoder().encode(data)
            return try await parent.request(
                path: "/billing/create",
                method: "POST",
                body: jsonData
            )
        }
        
        public func list() async throws -> ListBillingResponse {
            return try await parent.request(path: "/billing/list")
        }
    }
    
    public var billing: Billing {
        return Billing(parent: self)
    }
}
