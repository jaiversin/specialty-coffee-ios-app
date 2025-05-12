import Foundation

struct Order: Decodable, Identifiable {
    let id: String
    let items: [OrderItem]
    let total: Double
    let status: String
}

struct OrderItem: Decodable {
    let productId: String
    let quantity: Int
}
