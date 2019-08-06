//
//  EpisodeService.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-05.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import Foundation

typealias EpisodeResultHandler = (_ episodes: [Episode], _ error: Error?) -> Void

final class EpisodeService: APIManager {
    func fetchEpisodes(completion: @escaping EpisodeResultHandler) {
        fetch(path: "episode") { (data, error) in
            guard let data = data else {
                completion([], error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let episodeResults = try jsonDecoder.decode(EpisodeResults.self, from: data)
                completion(episodeResults.results, nil)
                
            } catch {
                completion([], error)
            }
        }
    }
}
