//
//  Pageable.swift
//  SpecialtyCoffeeApp
//
//  Created by Jhon Lopez on 5/8/25.
//

protocol Pageable: Decodable {
    var total: Int { get }
    var page: Int { get }
    var totalPages: Int { get }
}

struct PageableResult<T: Decodable>: Pageable {
    var total: Int
    var page: Int
    var totalPages: Int
    var entries: [T]
    
    init(total: Int = 0, page: Int = 0, totalPages: Int = 0, entries: [T] = []) {
        self.total = total
        self.page = page
        self.totalPages = totalPages
        self.entries = entries
    }

    enum CodingKeys: String, CodingKey {
        case total, page, totalPages, coffees, roasters, shops
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        total = try container.decode(Int.self, forKey: .total)
        page = try container.decode(Int.self, forKey: .page)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        
        switch T.self {
        case is Coffee.Type:
            entries = try container.decode([T].self, forKey: CodingKeys.coffees)
        case is Roaster.Type:
            entries = try container.decode([T].self, forKey: CodingKeys.roasters)
        case is Shop.Type:
            entries = try container.decode([T].self, forKey: CodingKeys.shops)
        default:
            entries = []
        }
    }
}
