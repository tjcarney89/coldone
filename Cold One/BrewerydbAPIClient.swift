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
    
    class func getBreweryID(name: String, completion: @escaping (String, String) -> ()) {
        let urlString = "http://api.brewerydb.com/v2/breweries?key=\(Secret.apiKey)&name=\(name)"
        guard let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        if let url = URL(string: urlStringEncoded) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data {
                    let json = JSON(data: data)
                    let idArray = json["data"].arrayValue.map({$0["id"].stringValue})
                    let nameArray = json["data"].arrayValue.map({$0["name"].stringValue})
                    if let id = idArray.first, let name = nameArray.first {
                        completion(id, name)
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    class func getBeersForBrewery(id: String, brewery: String, completion: @escaping ([Beer]) -> ()) {
        var beers = [Beer]()
        let urlString = "http://api.brewerydb.com/v2/brewery/\(id)/beers?key=\(Secret.apiKey)"
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let json = JSON(data: data)
                    let beerArray = json["data"].arrayValue
                    for beer in beerArray {
                        let name = beer["nameDisplay"].stringValue
                        let id = beer["id"].stringValue
                        let style = beer["style"]["name"].stringValue
                        let abv = beer["abv"].stringValue
                        let beer = Beer(name: name, id: id, abv: abv, style: style, brewery: brewery)
                        beers.append(beer)
                    }
                    completion(beers)
                }
            }
            dataTask.resume()
        }
        
    }
    
    class func getBreweryByLocation(latitude: Double, longitude: Double, radius: Int, completion: @escaping ([Brewery]) -> ()) {
        print("GETTING CALLED")
        var breweries = [Brewery]()
        let urlString = "http://api.brewerydb.com/v2/search/geo/point?key=\(Secret.apiKey)&lat=\(latitude)&lng=\(longitude)&radius=\(radius)"
        if let url = URL(string: urlString) {
            print("GOT URL")
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data {
                    let json = JSON(data: data)
                    let breweryArray = json["data"].arrayValue
                    for brewery in breweryArray {
                        let name = brewery["brewery"]["name"].stringValue
                        let id = brewery["brewery"]["id"].stringValue
                        let address = brewery["streetAddress"].stringValue
                        let locality = brewery["locality"].stringValue
                        let region = brewery["region"].stringValue
                        let type = brewery["locationTypeDisplay"].stringValue
                        let distance = brewery["distance"].doubleValue
                        let newBrewery = Brewery(name: name, id: id, locality: locality, region: region, type: type, address: address, distance: distance)
                        breweries.append(newBrewery)
                    }
                    completion(breweries)
                }
            })
            dataTask.resume()
        }
    }
    
    
    
}
