import Foundation

public struct Billing: Codable {
    public let id: String
    public let url: String
    public let amount: Double
    public let status: BillingStatus
    public let devMode: Bool
    public let methods: [BillingMethods]
    public let products: [Product]
    public let frequency: BillingKind
    public let nextBilling: String?
    public let customer: CustomerReference?
    public let accountId: String
    public let storeId: String
    public let createdAt: String
    public let updatedAt: String
    
    public struct Product: Codable {
        public let productId: String
        public let quantity: Int
    }
    
    public struct CustomerReference: Codable {
        public let id: String
        public let metadata: CustomerMetadata
    }
}

public struct BillingMetadata: Codable {
    public var fee: Double
    public var returnUrl: String?
    public var completionUrl: String?
}

public struct CreateBillingData: Codable {
    public var frequency: BillingKind
    public var methods: [BillingMethods]
    public var products: [Product]
    public var returnUrl: String
    public var completionUrl: String
    public var customerId: String?
    
    public struct Product: Codable {
        public var externalId: String
        public var name: String
        public var quantity: Int
        public var price: Int
        public var description: String?
        
        public init(
            externalId: String,
            name: String,
            quantity: Int,
            price: Int,
            description: String? = nil
        ) {
            self.externalId = externalId
            self.name = name
            self.quantity = quantity
            self.price = price
            self.description = description
        }
    }
    
    public init(
        frequency: BillingKind,
        methods: [BillingMethods],
        products: [Product],
        returnUrl: String,
        completionUrl: String,
        customerId: String? = nil
    ) {
        self.frequency = frequency
        self.methods = methods
        self.products = products
        self.returnUrl = returnUrl
        self.completionUrl = completionUrl
        self.customerId = customerId
    }
}
