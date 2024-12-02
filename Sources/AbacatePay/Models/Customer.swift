import Foundation

public struct CustomerMetadata: Codable {
    public var name: String?
    public var cellphone: String?
    public var email: String
    public var taxId: String?
    
    public init(
        name: String? = nil,
        cellphone: String? = nil,
        email: String,
        taxId: String? = nil
    ) {
        self.name = name
        self.cellphone = cellphone
        self.email = email
        self.taxId = taxId
    }
}
