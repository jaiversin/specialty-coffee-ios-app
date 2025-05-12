import Foundation

struct Roaster: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let location: String
    
    init(id: String, name: String, location: String) {
        self.id = id
        self.name = name
        self.location = location
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case location
    }
}
