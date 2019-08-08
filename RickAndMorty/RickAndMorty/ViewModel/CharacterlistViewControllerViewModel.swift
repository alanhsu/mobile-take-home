//
//  CharacterlistViewControllerViewModel.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-07.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import Foundation

class CharacterlistViewControllerViewModel: NSObject {
    
    @objc dynamic var characters: [Character] = []
    
    private var characterURLs:  [String]
    private var characterIds: [String]
    private let characterService = CharacterService()
    private var fetchedCharacters: [Character] = []
    
    init(charactersURLs: [String]) {
        self.characterURLs = charactersURLs
        
        var characterIdsToFetch: [String] = []
        characterURLs.forEach { (url) in
            if let id = url.components(separatedBy: "/").last {
                characterIdsToFetch.append(id)
            }
        }
        
        characterIds = characterIdsToFetch
    }
    
    func character(at indexPath: IndexPath) -> Character? {
        guard characters.indices.contains(indexPath.row) else { return nil }
        return characters[indexPath.row]
    }
    
    func fetchCharacters() {
        fetchedCharacters = []
        for id in characterIds {
            characterService.fetchCharacters(id: id) { (character, error) in
                if let character = character {
                    self.fetchedCharacters.append(character)
                    self.checkIfDone()
                }
            }
        }
    }
    
    func checkIfDone() {
        guard fetchedCharacters.count == characterIds.count else { return }
        characters = fetchedCharacters
    }
}
