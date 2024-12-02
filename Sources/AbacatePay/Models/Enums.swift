import Foundation

public enum BillingStatus: String, Codable, Sendable {
    case pending = "PENDING"
    case expired = "EXPIRED"
    case cancelled = "CANCELLED"
    case paid = "PAID"
    case refunded = "REFUNDED"
}

public enum BillingMethods: String, Codable, Sendable {
    case pix = "PIX"
}

public enum BillingKind: String, Codable, Sendable {
    case oneTime = "ONE_TIME"
}
