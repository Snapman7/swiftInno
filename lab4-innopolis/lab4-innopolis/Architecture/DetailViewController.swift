//
//  DetailViewController.swift
//  lab4-innopolis
//
//  Created by Ренат Хайруллин on 04.07.2023.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func dismissMe()
}

final class DetailViewController: UIViewController {

    var character: CDataCharacter? {
        didSet {
            guard let character else { return }
            setUpData(character: character)
        }
    }
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var changeStatusLabel: UIButton!
    @IBOutlet weak var speciesLabel: UILabel!
    
    var output: ViewOutput? = nil
    var delegate: DetailViewControllerDelegate?
    
    func setUpData(character: CDataCharacter) {
        nameLabel.text = "\(character.name ?? "")"
        speciesLabel.text = "Species: \(character.species ?? "")"
        locationLabel.text = "Location: \(character.location ?? "")"
        statusLabel.text = "Status: \(character.status ?? "")"
        genderLabel.text = "Species: \(character.gender ?? "")"
        personImageView.download(from: character.image ?? "")
    }
    
    

    @IBAction func changeStatusButtonDidTap(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Status", message: "", preferredStyle: .alert)
        
        let deadAction = UIAlertAction(title: "Dead", style: .default) { [self] _ in
            guard let character else { return }
            
            output?.viewDidTapButton(with: "Dead")
        }
        let aliveAction = UIAlertAction(title: "Alive", style: .default) { [self] _ in
            guard let character else { return }
            
            output?.viewDidTapButton(with: "Alive")
        }
        
        let unknownAction = UIAlertAction(title: "Unknown", style: .default) { [self] _ in
            guard let character else { return }
            
            output?.viewDidTapButton(with: "unknown")
        }

        alertController.addAction(deadAction)
        alertController.addAction(aliveAction)
        alertController.addAction(unknownAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
}

extension DetailViewController: ViewInput {
    func changeStatus(to status: String) {
        character?.status = status
        PersistentContainer.shared.saveContext()
        delegate?.dismissMe()
    }
    
    
}
