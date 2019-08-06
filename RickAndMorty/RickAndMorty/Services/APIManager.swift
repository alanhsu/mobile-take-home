//
//  APIManager.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-05.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import Foundation

typealias ResponseCompletion = (_ data: Data?, _ error: Error?) -> Void

class APIManager {
    /*
     Base url contains list of endpoints, possible improvement is to use the baseURL endpoint as a 'config' to drive all other endpoints. that way if
     endpoints change on the server side, no additional change is needed on the app side
     */
    private let baseURL = "https://rickandmortyapi.com/api/"
    
    func fetch(path: String, completion: @escaping ResponseCompletion) {
        let urlString = baseURL + path
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
            }
            if let data = data {
                completion(data, nil)
            }
        }
        task.resume()
    }
}
