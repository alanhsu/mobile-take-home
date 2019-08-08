//
//  CharacterManager.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-07.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import Foundation

/*
 Ideally this class would sync with something like UserDefaults so killed characters will persist
 */

class CharacterManager {
    static let sharedInstance = CharacterManager()
    
    private(set) var killedCharacterIds: Set<Int> = Set([])
    
    func kill(_ character: Character) {
        killedCharacterIds.insert(character.id)
    }
    
    func status(of character: Character) -> String {
        if killedCharacterIds.contains(character.id) {
            return "Dead"
        } else {
            return character.status
        }
    }
}
