//
//  CharacterService.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-05.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import Foundation

final class CharacterService: APIManager {
    func fetchCharacters() {
        fetch(path: "character") { (data, error) in
            //
        }
    }
}
