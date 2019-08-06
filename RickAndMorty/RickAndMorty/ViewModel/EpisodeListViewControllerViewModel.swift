//
//  EpisodeListViewControllerViewModel.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-05.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import Foundation

class EpisodeListViewControllerViewModel: NSObject {
    let episodeService = EpisodeService()
    
    @objc dynamic var episodes: [Episode] = []
    @objc dynamic var error: Error?

    var numberOfItems: Int {
        return episodes.count
    }
    
    func fetch() {
        episodeService.fetchEpisodes {[weak self] (episodes, error) in
            self?.episodes = episodes
        }
    }
    
    func title(indexPath: IndexPath) -> String? {
        guard episodes.indices.contains(indexPath.row) else { return nil }
        return episodes[indexPath.row].name
    }
}
