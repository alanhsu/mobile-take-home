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
            do {
                let character = try jsonDecoder.decode(Character.self, from: data)
                completion(character, nil)
                
            } catch {
                completion(nil, error)
            }
        }
    }
}
