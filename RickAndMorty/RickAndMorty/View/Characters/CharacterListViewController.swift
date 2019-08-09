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
    var loadObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        tableView.register(UINib(nibName: Constants.characterCellNib, bundle: nil), forCellReuseIdentifier: Constants.characterCellReuseId)
        addObserver()
        viewModel?.fetchCharacters()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.sortCharacters()
        tableView.reloadData()
    }
    
    func addObserver() {
        guard let viewModel = viewModel else { return }
        loadObservation = viewModel.observe(\.loadStatus, options: [.new, .old], changeHandler: { (viewModel, change) in
            guard viewModel.loadStatus == .loaded else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

extension CharacterListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Alive" : "Dead"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? (viewModel?.aliveCharacters.count ?? 0) : (viewModel?.deadCharacters.count ?? 0)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel,
            let character = (indexPath.section == 0) ? viewModel.aliveCharacter(at: indexPath) : viewModel.deadCharacters(at: indexPath) else {
            fatalError()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.characterCellReuseId, for: indexPath) as! CharacterCell
        cell.viewModel = CharacterCellViewModel(character: character)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension CharacterListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let character = (indexPath.section == 0) ? viewModel?.aliveCharacter(at: indexPath) : viewModel?.deadCharacters(at: indexPath),
            let viewController = storyboard.instantiateViewController(withIdentifier: "CharacterDetailViewController") as? CharacterDetailViewController else { return }
        viewController.viewModel = CharacterDetailViewControllerViewModel(character: character)
        show(viewController, sender: nil)
    }
}
