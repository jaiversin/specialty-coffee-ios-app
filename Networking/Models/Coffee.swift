import Foundation

struct Coffee: Identifiable, Decodable, Hashable {
    static func == (lhs: Coffee, rhs: Coffee) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let name: String
    let roaster: Roaster
    let origin: String
    let roastLevel: String
    let description: String?
    let price: Double
    let availableQuantity: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case roaster
        case origin
        case roastLevel
        case description
        case price
        case availableQuantity
    }
}

//struct CoffeePaging: Decodable, Pageable {
//    let coffees: [Coffee]
//    var total: Int?
//    var page: Int?
//    var totalPages: Int?
//}


