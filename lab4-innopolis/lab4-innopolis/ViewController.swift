//
//  ViewController.swift
//  lab4-innopolis
//
//  Created by Ренат Хайруллин on 02.07.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var frc: NSFetchedResultsController<CDataCharacter> = {
        let request = CDataCharacter.fetchRequest()
        request.sortDescriptors = [
            .init(key: "id", ascending: true)
        ]
        
        let frc = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: PersistentContainer.shared.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        frc.delegate = self
        
        return frc
    }()
    
    
    private let manager: NetworkManagerProtocol = NetworkManger()
    
    
    override func viewDidAppear(_ animated: Bool) {
        let entersBefore = UserDefaults.standard.integer(forKey: "enters")
        UserDefaults.standard.set(entersBefore + 1, forKey: "enters")
        if (entersBefore + 1) % 3 == 0 {
            let alert = UIAlertController(title: "You entered \(entersBefore + 1) times", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    
        do {
            try frc.performFetch()
        } catch {
            print(error)
        }
        
        
        if frc.fetchedObjects?.count == 0 {
            loadCharacters()
        }
        
    }

    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }

    
    private func loadCharacters() {
        for i in 1...42 {
            manager.fetchCharacters(on: i) { result in
                switch result {
                case let .success(response):
                    PersistentContainer.shared.performBackgroundTask { backgroundContext in
                        for character in response.results! {
                            let newCharacter = CDataCharacter(context: backgroundContext)
                            newCharacter.setUpData(character: character)
                            PersistentContainer.shared.saveContext(backgroundContext: backgroundContext)
                        }
                    }
                case let .failure(error):
                    print(error)
                    
                }
            }
        }
    }
    
    // MARK - UITableViewDataSource, UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = frc.object(at: indexPath)
        guard let personCell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as? PersonTableViewCell
        else { return UITableViewCell() }
        
        personCell.setUpData(character)
        
        return personCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = frc.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let character = frc.object(at: indexPath)
        
        guard let detailedViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        detailedViewController.delegate = self
        
        present(detailedViewController, animated: true)
        
        detailedViewController.character = character
        detailedViewController.indexPath = indexPath
    }
    
    
}


// MARK - DetailViewController Delegate 
extension ViewController: DetailViewControllerDelegate {
    func changeStatus(with indexPath: IndexPath, to status: String) {
        let character = frc.object(at: indexPath)
        character.status = status
        PersistentContainer.shared.saveContext()
        
        dismiss(animated: true)
    }
    
    
}

