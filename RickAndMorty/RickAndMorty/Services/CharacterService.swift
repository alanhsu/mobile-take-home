//
//  CharacterService.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-05.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import Foundation

typealias CharacterResultHandler = (_ character: Character?, _ error: Error?) -> Void

final class CharacterService: APIManager {
    func fetchCharacters(id: String, completion: @escaping CharacterResultHandler) {
        let path = "character/" + id
        fetch(path: path) { (data, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            do {
                let character = try jsonDecoder.decode(Character.self, from: data)
                completion(character, nil)
                
            } catch {
                completion(nil, error)
            }
        }
    }
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
