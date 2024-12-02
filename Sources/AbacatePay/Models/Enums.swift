import Foundation

public enum BillingStatus: String, Codable {
    case pending = "PENDING"
    case expired = "EXPIRED"
    case cancelled = "CANCELLED"
    case paid = "PAID"
    case refunded = "REFUNDED"
}

public enum BillingMethods: String, Codable {
    case pix = "PIX"
}

public enum BillingKind: String, Codable {
    case oneTime = "ONE_TIME"
}
