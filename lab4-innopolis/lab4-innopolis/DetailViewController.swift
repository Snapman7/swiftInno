//
//  DetailViewController.swift
//  lab4-innopolis
//
//  Created by Ренат Хайруллин on 04.07.2023.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func changeStatus(with id: Int, to status: Character.Status)
}

final class DetailViewController: UIViewController {

    var data: Character? {
        didSet {
            guard let data else { return }
            setUpData(data)
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
    
    

    func setUpData(_ character: Character) {
        nameLabel.text = "\(character.name)"
        speciesLabel.text = "Species: \(character.species)"
        locationLabel.text = "Location: \(character.location)"
        statusLabel.text = "Status: \(character.status.rawValue)"
        genderLabel.text = "Species: \(character.gender.rawValue)"
        personImageView.download(from: character.image)
    }

    @IBAction func changeStatusButtonDidTap(_ sender: Any) {
        let alertController = UIAlertController(title: "Change Status", message: "", preferredStyle: .alert)
        
        let deadAction = UIAlertAction(title: "Dead", style: .default) { [self] _ in
            data?.status = .dead
            guard let data else { return }
            
            delegate?.changeStatus(with: data.id, to: data.status)
        }
        let aliveAction = UIAlertAction(title: "Alive", style: .default) { [self] _ in
            data?.status = .alive
            guard let data else { return }
            
            delegate?.changeStatus(with: data.id, to: data.status)
        }
        
        let unknownAction = UIAlertAction(title: "Unknown", style: .default) { [self] _ in
            data?.status = .unknown
            guard let data else { return }
            
            delegate?.changeStatus(with: data.id, to: data.status)
        }
        
        alertController.addAction(deadAction)
        alertController.addAction(aliveAction)
        alertController.addAction(unknownAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
}
