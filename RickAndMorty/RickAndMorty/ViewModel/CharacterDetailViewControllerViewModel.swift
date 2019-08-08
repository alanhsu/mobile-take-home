//
//  CharacterDetailViewControllerViewModel.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-08.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import Foundation

class CharacterDetailViewControllerViewModel {
    private(set) var character: Character
    
    var name: String {
        return character.name
    }
    
    var status: String {
        return CharacterManager.sharedInstance.status(of: character)
    }
    
    var species: String {
        return character.species
    }
    
    var gender: String {
        return character.gender
    }
    
    var origin: String {
        return character.origin.name
    }
    
    var location: String {
        return character.location.name
    }
    
    var imageURL: URL? {
        return URL(string: character.image)
    }
    
    init(character: Character) {
        self.character = character
    }
}
