//
//  ViewController.swift
//  lab4-innopolis
//
//  Created by Ренат Хайруллин on 02.07.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var characters: [Character]? = []
    private let manager: NetworkManagerProtocol = NetworkManger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        loadCharacters()
    }

    
    private func loadCharacters() {
        for i in 1...42 {
            manager.fetchCharacters(on: i) { result in
                switch result {
                case let .success(response):
                    self.characters! += response.results!
                    self.characters?.sort(by: { $0.id < $1.id })
                    self.tableView.reloadData()
                case let .failure(error):
                    print(error)
                    
                }
            }
        }
    }
    
    // MARK - UITableViewDataSource, UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let personCell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell") as? PersonTableViewCell
        else { return UITableViewCell() }
        
        let cellData = characters![indexPath.row]
        
        personCell.setUpData(cellData)
        
        return personCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let detailedViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        detailedViewController.delegate = self
        
        present(detailedViewController, animated: true)
        
        detailedViewController.data = characters![indexPath.row]
    }
    
    
}


// MARK - DetailViewController Delegate 
extension ViewController: DetailViewControllerDelegate {
    func changeStatus(with id: Int, to status: Character.Status) {
        if let index = characters!.firstIndex(where: { $0.id == id }) {
            characters?[index].status = status
            tableView.reloadData()
        }
        
        dismiss(animated: true)
    }
    
    
}

