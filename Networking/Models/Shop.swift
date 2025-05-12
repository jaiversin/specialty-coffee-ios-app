import Foundation

struct Shop: Decodable, Identifiable {
    let id: String
    let name: String
    let location: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case location
    }
}
