//
//  RaMInteractor.swift
//  lab4-innopolis
//
//  Created by Ренат Хайруллин on 12.07.2023.
//

import Foundation
import CoreData

protocol InteractorInput {
    func changeStatus(to status: String)
}

protocol InteractorOutput: AnyObject {
    func didUpdateValue(_ character: CDataCharacter)
}

class Interactor {
    
    private var character: CDataCharacter
    weak var output: InteractorOutput?
    
    init(character: CDataCharacter, output: InteractorOutput? = nil) {
        self.character = character
        self.output = output
    }
    
}

extension Interactor: InteractorInput {
    func changeStatus(to status: String) {
        character.status = status
        output?.didUpdateValue(character)
    }
}

