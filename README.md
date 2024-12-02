# abacatepay-swift-sdk
AbacatePay Swift SDK for you to start receiving payments in seconds.

## Example
```swift
import Foundation
import AbacatePay

let abacatePay = AbacatePay(apiKey: "{{ key }}")

let billingData = CreateBillingData(
    frequency: .oneTime,
    methods: [.pix],
    products: [
        .init(
            externalId: "PLANO-PRO",
            name: "PRO Plan",
            quantity: 1,
            price: 1000
        )
    ],
    returnUrl: "https://mysite.com/app",
    completionUrl: "https://mysite.com/payment/success",
    automaticTaxReceipt: true
)

do {
    let billing = try await abacatePay.billing.create(data: billingData)
    print(billing)
    /*
    {
        id: "bill_12345667",
        url: "https://abacatepay.com/pay/bill_12345667",
        amount: 1000,
        status: "PENDING",
        devMode: true,
        methods: ["PIX"],
        frequency: "ONE_TIME",
        nextBilling: nil,
        createdAt: "2024-11-04T18:38:28.573",
        updatedAt: "2024-11-04T18:38:28.573",
    }
    */
} catch {
    print("Error creating billing:", error)
}
```
