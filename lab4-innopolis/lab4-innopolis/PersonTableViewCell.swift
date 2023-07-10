//
//  PersonTableViewCell.swift
//  lab4-innopolis
//
//  Created by Ренат Хайруллин on 02.07.2023.
//

import UIKit

struct CharacterStruct: Codable {
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
    
    func setUpData(_ character: CDataCharacter) {
        nameLabel.text = "\(character.name ?? "")"
        speciesLabel.text = "Species: \(character.species ?? "")"
        locationLabel.text = "Location: \(character.location ?? "")"
        statusLabel.text = "Status: \(character.status ?? "")"
        genderLabel.text = "Species: \(character.gender ?? "")"
        personImageView.download(from: character.image ?? "")
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
