//
//  Episode.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-05.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import Foundation

class Episode: NSObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url
    }
    
    var id: Int
    var name: String
    var airDate: String
    var episode: String
    var characters: [String]
    var url: String
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        airDate = try values.decode(String.self, forKey: .airDate)
        episode = try values.decode(String.self, forKey: .episode)
        characters = try values.decode([String].self, forKey: .characters)
        url = try values.decode(String.self, forKey: .url)
    }
}
