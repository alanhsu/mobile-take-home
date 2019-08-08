//
//  CharacterCellViewModel.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-07.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import Foundation

class CharacterCellViewModel: NSObject {
    var character: Character
    
    var imageURL: URL? {
        return URL(string: character.image)!
    }
    
    var name: String {
        return character.name
    }
    
    var status: String {
        return "Status: " + character.status
    }
    
    init(character: Character) {
        self.character = character
    }
}
