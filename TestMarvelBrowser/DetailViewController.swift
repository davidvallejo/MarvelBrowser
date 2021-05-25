//
//  DetailViewController.swift
//  TestMarvelMonolithic
//
//  Created by David Vallejo on 24/5/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var id: Int = 0
    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()

        getCharacter()
    }
    
    func getCharacter() {
        MarvelApi().getCharacter(id: self.id) { result in
            switch result {
            case .success(let value):
                self.character = value.data.results[0]
                
                DispatchQueue.main.async {
                    self.displayData()
                }
            case .failure(_):
                print("Error")
            }
        }
    }

    func displayData() {
        if let character = character {
            self.title = character.name
            self.descriptionLabel.text = character.description
        }
    }
}
