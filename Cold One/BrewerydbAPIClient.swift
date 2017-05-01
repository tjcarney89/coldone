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
    
//    class func getBeer(name: String, completion: @escaping (Beer) -> ()) {
//        let urlString = "http://api.brewerydb.com/v2/beers?key=\(Secret.apiKey)&name=\(name)"
//        guard let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
//        if let url = URL(string: urlStringEncoded) {
//            let session = URLSession.shared
//            let dataTask = session.dataTask(with: url) { (data, response, error) in
//                if let data = data {
//                    let json = JSON(data: data)
//                    let beer = Beer(dict: json)
//                    completion(beer)
//                }
//            }
//            dataTask.resume()
//        } else {
//            print("COULD NOT CREATE URL")
//        }
//    }
    
    class func searchBeer(name: String, completion: @escaping ([Beer]) -> ()) {
        var beers = [Beer]()
        let urlString = "http://api.brewerydb.com/v2/search?key=\(Secret.apiKey)&q=\(name)&type=beer&withBreweries=Y"
        guard let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        if let url = URL(string: urlStringEncoded) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data {
                    let json = JSON(data: data)
                    let beerArray = json["data"].arrayValue
                    for beer in beerArray {
                        let id = beer["id"].stringValue
                        let name = beer["name"].stringValue
                        let abv = beer["abv"].stringValue
                        let style = beer["style"]["name"].stringValue
                        let breweryArray = beer["breweries"].arrayValue
                        var unwrappedBeerBrewery: Brewery?
                        for brewery in breweryArray {
                            let breweryName = brewery["name"].stringValue
                            let breweryID = brewery["id"].stringValue
                            let addressArray = brewery["locations"].arrayValue.map({$0["streetAddress"].string})
                            let localityArray = brewery["locations"].arrayValue.map({$0["locality"].string})
                            let regionArray = brewery["locations"].arrayValue.map({$0["region"].stringValue})
                            let typeArray = brewery["locations"].arrayValue.map({$0["locationTypeDisplay"].stringValue})
                            guard let breweryAddress = addressArray.first, let breweryLocality = localityArray.first, let breweryRegion = regionArray.first, let breweryType = typeArray.first else {return}
                            let newBrewery = Brewery(name: breweryName, id: breweryID, locality: breweryLocality, region: breweryRegion, type: breweryType, address: breweryAddress, distance: nil)
                            unwrappedBeerBrewery = newBrewery
                        }
                        guard let beerBrewery = unwrappedBeerBrewery else {return}
                        let newBeer = Beer(name: name, id: id, abv: abv, style: style, brewery: beerBrewery)
                        beers.append(newBeer)
                    }
                }
                completion(beers)
            })
            dataTask.resume()
        }
    }
    
//    class func getBeerBrewery(beer: Beer, completion: @escaping (Beer) -> ()) {
//        let urlString = "http://api.brewerydb.com/v2/beer/\(beer.id)/breweries?key=\(Secret.apiKey)"
//        if let url = URL(string: urlString) {
//            let session = URLSession.shared
//            let dataTask = session.dataTask(with: url) { (data, response, error) in
//                if let data = data {
//                    let json = JSON(data: data)
//                    let breweryArray = json["data"].arrayValue.map({$0["name"].stringValue})
//                    if let brewery = breweryArray.first {
//                        beer.brewery = brewery
//                        completion(beer)
//                    }
//                }
//            }
//            dataTask.resume()
//        }
//    }
    
//    class func getBreweryID(name: String, completion: @escaping (String, String) -> ()) {
//        let urlString = "http://api.brewerydb.com/v2/breweries?key=\(Secret.apiKey)&name=\(name)"
//        guard let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
//        if let url = URL(string: urlStringEncoded) {
//            let session = URLSession.shared
//            let dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
//                if let data = data {
//                    let json = JSON(data: data)
//                    let idArray = json["data"].arrayValue.map({$0["id"].stringValue})
//                    let nameArray = json["data"].arrayValue.map({$0["name"].stringValue})
//                    if let id = idArray.first, let name = nameArray.first {
//                        completion(id, name)
//                    }
//                }
//            })
//            dataTask.resume()
//        }
//    }
    
    class func searchBrewery(name: String, completion: @escaping (String, String) -> ()) {
        let urlString = "http://api.brewerydb.com/v2/search?key=\(Secret.apiKey)&q=\(name)&type=brewery"
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
                        print("1. Got the ID: \(id)")
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    class func getBreweryLocation(id: String, name: String, completion: @escaping (Brewery?) -> ()) {
        var newBrewery: Brewery?
        let urlString = "http://api.brewerydb.com/v2/brewery/\(id)/locations?key=\(Secret.apiKey)"
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data {
                    let json = JSON(data: data)
                    let breweryArray = json["data"].arrayValue
                    if let brewery = breweryArray.first {
                        let address = brewery["streetAddress"].string
                        let locality = brewery["locality"].string
                        let region = brewery["region"].stringValue
                        let type = brewery["locationTypeDisplay"].stringValue
                        newBrewery = Brewery(name: name, id: id, locality: locality, region: region, type: type, address: address, distance: nil)
                        print("2. Got the Brewery: \(newBrewery)")
                    }
                }
                completion(newBrewery)
            })
            dataTask.resume()
        }
    }
    
    class func getBeersForBrewery(brewery: Brewery, completion: @escaping ([Beer]) -> ()) {
        print("3. Getting beers for \(brewery)")
        var beers = [Beer]()
        let urlString = "http://api.brewerydb.com/v2/brewery/\(brewery.id)/beers?key=\(Secret.apiKey)"
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
                    print("4. Got beers for \(brewery): \(beers)")
                }
            }
            dataTask.resume()
        }
    }
    
    class func getBreweryByLocation(latitude: Double, longitude: Double, radius: Int, completion: @escaping ([Brewery]) -> ()) {
        var breweries = [Brewery]()
        let urlString = "http://api.brewerydb.com/v2/search/geo/point?key=\(Secret.apiKey)&lat=\(latitude)&lng=\(longitude)&radius=\(radius)"
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data {
                    let json = JSON(data: data)
                    let breweryArray = json["data"].arrayValue
                    for brewery in breweryArray {
                        let name = brewery["brewery"]["name"].stringValue
                        let id = brewery["brewery"]["id"].stringValue
                        let address = brewery["streetAddress"].string
                        let locality = brewery["locality"].string
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
