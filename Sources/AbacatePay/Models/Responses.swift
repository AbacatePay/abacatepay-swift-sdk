import Foundation

public enum CreateBillingResponse: Sendable {
    case success(billing: Billing)
    case error(message: String)
}

public enum ListBillingResponse: Sendable {
    case success(billings: [Billing])
    case error(message: String)
}

extension CreateBillingResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case error, billing
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let error = try container.decodeIfPresent(String.self, forKey: .error) {
            self = .error(message: error)
        } else if let billing = try container.decodeIfPresent(Billing.self, forKey: .billing) {
            self = .success(billing: billing)
        } else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Invalid response"
                )
            )
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
            case .error(let message):
                try container.encode(message, forKey: .error)
            case .success(let billing):
                try container.encode(billing, forKey: .billing)
        }
    }
}

extension ListBillingResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case error, billings
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let error = try container.decodeIfPresent(String.self, forKey: .error) {
            self = .error(message: error)
        } else if let billings = try container.decodeIfPresent([Billing].self, forKey: .billings) {
            self = .success(billings: billings)
        } else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Invalid response"
                )
            )
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
            case .error(let message):
                try container.encode(message, forKey: .error)
            case .success(let billings):
                try container.encode(billings, forKey: .billings)
        }
    }
}
