//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-08.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import Foundation
import UIKit

class CharacterDetailViewController: UIViewController {
    
    var viewModel: CharacterDetailViewControllerViewModel?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.name
        speciesLabel.text = viewModel.species
        originLabel.text = viewModel.origin
        genderLabel.text = viewModel.gender
        locationLabel.text = viewModel.location
        
        updateStatus()
        
        if let imageURL = viewModel.imageURL {
            let imageData = try! Data(contentsOf: imageURL, options: .mappedIfSafe)
            imageView.image = UIImage(data: imageData)
        }
    }
    
    func updateStatus() {
        guard let viewModel = viewModel else { return }
        statusLabel.text = viewModel.status
    }
    
    @IBAction func killCharacterDidTap(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        presentKillOption(with: viewModel.character)
    }
}

extension CharacterDetailViewController {
    func presentKillOption(with character: Character) {
        let alert = UIAlertController(title: "Kill " + character.name, message: "Are you sure you want to do this?", preferredStyle: .alert)

        let killAction = UIAlertAction(title: "I have no regard for human/alien life", style: .destructive) { (action) in
            self.kill(character)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // no-op
        }

        alert.addAction(killAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

    func presentUnkillableAlert(_ character: Character) {
        let alert = UIAlertController(title: character.name + " is already dead", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Okay", style: .cancel) { (action) in
            // no-op
        }
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    func kill(_ character: Character) {
        if character.status == "Dead" {
            presentUnkillableAlert(character)
        } else {
            CharacterManager.sharedInstance.kill(character)
            updateStatus()
        }
    }
}
