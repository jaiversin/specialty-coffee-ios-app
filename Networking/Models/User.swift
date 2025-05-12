//
//  User.swift
//  SpecialtyCoffeeApp
//
//  Created by Jhon Lopez on 5/5/25.
//

struct LoggedInUser: Decodable {
    let user: User
    let token: String
}

struct User: Decodable {
    let id: String
    let email: String
    let name: String
    let role: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
        case name
        case role
    }
}
