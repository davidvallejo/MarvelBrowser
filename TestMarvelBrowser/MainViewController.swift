//
//  ListTableViewController.swift
//  TestMarvelMonolithic
//
//  Created by David Vallejo on 24/5/21.
//

import UIKit

class ListTableViewController: UITableViewController {
    var characters: [Character]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        retrieveList()
    }
    
    func retrieveList() {
        MarvelApi().getCharacterList(offset: 0, limit: 60) { result in
            switch result {
            case .success(let value):
                self.characters = value.data.results
                
                self.displayData()
            case .failure(_):
                print("Error")
            }
        }
    }
    
    func displayData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell

        if let characters = characters {
            let character = characters[indexPath.row]
            cell.textLabel?.text = character.name
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let characters = characters {
            let character = characters[indexPath.row]
            
            let detailViewController = DetailViewController()
            detailViewController.id = character.id
            self.navigationController?.pushViewController(detailViewController, animated: true)
            
        }
    }
}
