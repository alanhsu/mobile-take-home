//
//  Character.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-05.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import Foundation

class Character: NSObject, Codable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var image: String
    var origin: Origin
    var location: Location
    var created: Date
}

class Origin: Codable {
    var name: String
    var url: String
}

class Location: Codable {
    var name: String
    var url: String
}
