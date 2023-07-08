//
//  Character.swift
//  lab4-innopolis
//
//  Created by Ренат Хайруллин on 08.07.2023.
//

import Foundation

struct Character: Codable {
    enum Status:String, Codable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
    
    enum Gender:String, Codable {
        case female = "Female"
        case male = "Male"
        case genderless = "Genderless"
        case unknown = "unknown"
    }
    
    let id: Int
    let name: String
    var status: Status
    let species: String
    let gender: Gender
    let location: Location
    let image: String
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, gender, image
        case location
    }
}

struct Location: Codable {
    let name: String
    let url: String
    enum CodingKeys: String, CodingKey {
        case name, url
    }
}
