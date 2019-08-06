//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-05.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import UIKit

enum EpisodeListViewControllerConstants {
    static let episodeCellNib = "EpisodeCell"
    static let episodeCellReuseId = "episodeCellReuseId"
}

class EpisodeListViewController: UITableViewController {
    typealias Constants = EpisodeListViewControllerConstants
    let viewModel = EpisodeListViewControllerViewModel()
    var episodesObserver: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: Constants.episodeCellNib, bundle: nil), forCellReuseIdentifier: Constants.episodeCellReuseId)
        addObservers()
        viewModel.fetch()
    }
    
    private func addObservers() {
        episodesObserver = viewModel.observe(\.episodes, options: [.new, .old]) {[weak self] (viewModel, change) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension EpisodeListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.episodeCellReuseId, for: indexPath) as? EpisodeCell else {
            fatalError()
        }
        cell.titleLabel.text = viewModel.title(indexPath: indexPath)
        return cell
    }
}
