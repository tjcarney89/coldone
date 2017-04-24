//
//  BrewerydbAPIClient.swift
//  Cold One
//
//  Created by TJ Carney on 4/24/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import Foundation
import SwiftyJSON


final class BrewerydbAPIClient {
    
    class func getBeer(name: String, completion: @escaping (Beer) -> ()) {
        let urlString = "http://api.brewerydb.com/v2/beers?key=\(Secret.apiKey)&name=\(name)"
        guard let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        if let url = URL(string: urlStringEncoded) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let json = JSON(data: data)
                    let beer = Beer(dict: json)
                    completion(beer)
                }
            }
            dataTask.resume()
        } else {
            print("COULD NOT CREATE URL")
        }
    }
    
    class func getBeerBrewery(beer: Beer, completion: @escaping (Beer) -> ()) {
        let urlString = "http://api.brewerydb.com/v2/beer/\(beer.id)/breweries?key=\(Secret.apiKey)"
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let json = JSON(data: data)
                    let breweryArray = json["data"].arrayValue.map({$0["name"].stringValue})
                    if let brewery = breweryArray.first {
                        beer.brewery = brewery
                        completion(beer)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
}
