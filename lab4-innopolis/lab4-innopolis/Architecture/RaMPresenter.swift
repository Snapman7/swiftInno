//
//  RaMPresenter.swift
//  lab4-innopolis
//
//  Created by Ренат Хайруллин on 12.07.2023.
//

import Foundation


class Presenter {
    
    let interactor: InteractorInput
    weak var view: ViewInput?
    
    init(interactor: InteractorInput) {
        self.interactor = interactor
    }
}

extension Presenter: ViewOutput {
    func viewDidTapButton(with status: String) {
        interactor.changeStatus(to: status)
    }
}

extension Presenter: InteractorOutput {
    func didUpdateValue(_ character: CDataCharacter) {
        view?.changeStatus(to: character.status ?? "")
    }

}
