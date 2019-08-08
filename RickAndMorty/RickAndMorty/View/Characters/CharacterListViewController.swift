//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-07.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import Foundation
import UIKit

enum CharacterListViewControllerConstants {
    static let characterCellNib = "CharacterCell"
    static let characterCellReuseId = "characterCellReuseId"
}

class CharacterListViewController: UITableViewController {
    typealias Constants = CharacterListViewControllerConstants
    var viewModel: CharacterlistViewControllerViewModel?
    var charactersObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: Constants.characterCellNib, bundle: nil), forCellReuseIdentifier: Constants.characterCellReuseId)
        
        addObserver()
        viewModel?.fetchCharacters()
    }
    
    func addObserver() {
        guard let viewModel = viewModel else { return }
        charactersObservation = viewModel.observe(\.characters, options: [.new, .old], changeHandler: { (_, _) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

extension CharacterListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.characters.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel, let character = viewModel.character(at: indexPath) else {
            fatalError()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.characterCellReuseId, for: indexPath) as! CharacterCell
        cell.viewModel = CharacterCellViewModel(character: character)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension CharacterListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let character = viewModel?.character(at: indexPath) else { return }
        presentKillOption(with: character)
    }
}

extension CharacterListViewController {
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
        let alert = UIAlertController(title: character.name + "is already dead", message: nil, preferredStyle: .alert)
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
            tableView.reloadData()
        }
    }
}
