//
//  PersonTableViewCell.swift
//  lab4-innopolis
//
//  Created by Ренат Хайруллин on 02.07.2023.
//

import UIKit

final class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var personImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var statusLabel : UILabel!
    @IBOutlet weak var speciesLabel : UILabel!
    @IBOutlet weak var genderLabel : UILabel!
    @IBOutlet weak var locationLabel : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpData(_ character: Character) {
        nameLabel.text = "\(character.name)"
        speciesLabel.text = "Species: \(character.species)"
        locationLabel.text = "Location: \(character.location.name)"
        statusLabel.text = "Status: \(character.status.rawValue)"
        genderLabel.text = "Species: \(character.gender.rawValue)"
        personImageView.download(from: character.image)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        speciesLabel.text = nil
        locationLabel.text = nil
        statusLabel.text = nil
        genderLabel.text = nil
        personImageView.image = nil
    }

}
