//
//  CDataCharacter+CoreDataProperties.swift
//  lab4-innopolis
//
//  Created by Ренат Хайруллин on 10.07.2023.
//
//

import Foundation
import CoreData


extension CDataCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDataCharacter> {
        return NSFetchRequest<CDataCharacter>(entityName: "CDataCharacter")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var species: String?
    @NSManaged public var status: String?
    @NSManaged public var gender: String?
    @NSManaged public var location: String?
    @NSManaged public var image: String?
    
    func setUpData(character: CharacterStruct) {
        self.id = Int32(character.id)
        self.gender = character.gender.rawValue
        self.name = character.name
        self.status = character.status.rawValue
        self.location = character.location.name
        self.image = character.image
        self.species = character.species
    }

}

extension CDataCharacter : Identifiable {

}
