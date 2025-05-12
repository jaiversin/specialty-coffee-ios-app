import Foundation

struct Price: Decodable, Identifiable {
    let id: String
    let coffeeId: String
    let shopId: String
    let amount: Double
    let validFrom: Date
    let validTo: Date?
}
