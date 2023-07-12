//
//  ResponseReturn.swift
//  lab4-innopolis
//
//  Created by Ренат Хайруллин on 08.07.2023.
//

import Foundation

struct Characters: Codable {
    var results: [CharacterStruct]? = []
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
