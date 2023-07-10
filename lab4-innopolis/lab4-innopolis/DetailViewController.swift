//
//  DetailViewController.swift
//  lab4-innopolis
//
//  Created by Ренат Хайруллин on 04.07.2023.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func changeStatus(with indexPath: IndexPath, to status: String)
}

final class DetailViewController: UIViewController {

    var character: CDataCharacter? {
        didSet {
            guard let character else { return }
            setUpData(character)
        }
    }
    
    weak var delegate: DetailViewControllerDelegate?
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var changeStatusLabel: UIButton!
    @IBOutlet weak var speciesLabel: UILabel!
    var indexPath: IndexPath?
    
    

    func setUpData(_ character: CDataCharacter) {
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
            character?.status = "Dead"
            guard let character else { return }
            guard let indexPath else { return }
            
            delegate?.changeStatus(with: indexPath, to: character.status ?? "")
        }
        let aliveAction = UIAlertAction(title: "Alive", style: .default) { [self] _ in
            character?.status = "Alive"
            guard let character else { return }
            guard let indexPath else { return }
            
            delegate?.changeStatus(with: indexPath, to: character.status ?? "")
        }
        
        let unknownAction = UIAlertAction(title: "Unknown", style: .default) { [self] _ in
            character?.status = "unknown"
            guard let character else { return }
            guard let indexPath else { return }
            
                delegate?.changeStatus(with: indexPath, to: character.status ?? "")
        }

        alertController.addAction(deadAction)
        alertController.addAction(aliveAction)
        alertController.addAction(unknownAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
}
