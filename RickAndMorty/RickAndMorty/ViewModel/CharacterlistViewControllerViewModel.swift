//
//  CharacterlistViewControllerViewModel.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-07.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import Foundation

class CharacterlistViewControllerViewModel: NSObject {
    @objc enum LoadStatus: Int {
        case none
        case loading
        case loaded
    }
    
    @objc dynamic var loadStatus: LoadStatus = .none
    var aliveCharacters: [Character] = []
    var deadCharacters: [Character] = []
    
    private var characterURLs: [String]
    private var characterIds: [String]
    private let characterService = CharacterService()
    private var fetchedCharacters: [Character] = []
    
    init(charactersURLs: [String]) {
        self.characterURLs = charactersURLs
        
        /*
         Ideally the API would return a list of characterIds and not a list of endpoints to call,
         since the /character path is already available
         */
        var characterIdsToFetch: [String] = []
        characterURLs.forEach { (url) in
            if let id = url.components(separatedBy: "/").last {
                characterIdsToFetch.append(id)
            }
        }
        
        characterIds = characterIdsToFetch
    }
    
    func aliveCharacter(at indexPath: IndexPath) -> Character? {
        guard aliveCharacters.indices.contains(indexPath.row) else { return nil }
        return aliveCharacters[indexPath.row]
    }
    
    func deadCharacters(at indexPath: IndexPath) -> Character? {
        guard deadCharacters.indices.contains(indexPath.row) else { return nil }
        return deadCharacters[indexPath.row]
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
        sortCharacters()
        loadStatus = .loaded
    }
    
    func sortCharacters() {
        guard fetchedCharacters.count > 0 else { return }
        
        // sort by server status and local status
        aliveCharacters = fetchedCharacters.filter { $0.status == "Alive" && CharacterManager.sharedInstance.status(of: $0) == "Alive" }
        deadCharacters = fetchedCharacters.filter { $0.status == "Dead" || CharacterManager.sharedInstance.status(of: $0) == "Dead" }
        
        // Sort by date
        aliveCharacters.sort { (character1, character2) -> Bool in
            return character1.created < character2.created
        }
        
        deadCharacters.sort { (character1, character2) -> Bool in
            return character1.created < character2.created
        }
    }
}
