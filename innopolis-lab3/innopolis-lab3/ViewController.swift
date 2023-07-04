//
//  ViewController.swift
//  innopolis-lab3
//
//  Created by Ренат Хайруллин on 24.06.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var initialsView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var universityTextLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var changeUniversityButton: UIButton!

    @IBOutlet weak var cityTextLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var changeCityButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: initialsView.bounds.width, height: initialsView.bounds.height))
        initialsLabel.textAlignment = .center
        initialsLabel.textColor = UIColor.black
        initialsLabel.font = UIFont.systemFont(ofSize: 40)
        initialsView.addSubview(initialsLabel)
        
        initialsView.layer.cornerRadius = initialsView.bounds.width / 2
        initialsView.clipsToBounds = true
        let halfScreenWidth = UIScreen.main.bounds.width / 2
        initialsView.widthAnchor.constraint(equalToConstant: halfScreenWidth).isActive = true
        initialsView.heightAnchor.constraint(equalToConstant: halfScreenWidth).isActive = true
        
        let initials = "RK"
        initialsLabel.text = initials
        
        initialsView.backgroundColor = .gray



        nameLabel.textAlignment = .center
        let attributedText = NSAttributedString(string: "Renat Khairullin", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        nameLabel.attributedText = attributedText
        nameLabel.font = UIFont.systemFont(ofSize: 24)

        universityLabel.text = "University"
        universityLabel.textColor = UIColor.gray
        universityTextLabel.text = "Innopolis University"
        
        cityLabel.text = "City"
        cityLabel.textColor = UIColor.gray
        cityTextLabel.text = "Innopolis"
    }
    

    
    
    @IBAction func changeCityButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Insert new value", message: "Insert new value", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "New value"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            if let textField = alertController.textFields?.first, let newCity = textField.text {
                self.cityTextLabel.text = newCity
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
    }


    @IBAction func changeUniversityButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Insert new value", message: "Insert new value", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "New value"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            if let textField = alertController.textFields?.first, let newUniversity = textField.text {
                self.universityTextLabel.text = newUniversity
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
    }


}
