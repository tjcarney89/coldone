//
//  BeerDataStore.swift
//  Cold One
//
//  Created by TJ Carney on 4/24/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import Foundation

final class BeerDataStore {
    static let shared = BeerDataStore()
    private init () {}
    
    var savedBeers = [Beer]()
    var pouredBeers = [Beer]()
    var currentBreweryBeers = [Beer]()
    var currentBeer = [Beer]()
    var breweries = [Brewery]()
    
//    func getBeer(name: String, completion: @escaping (Beer) -> ()) {
//        currentBeer.removeAll()
//        BrewerydbAPIClient.getBeer(name: name) { (beer) in
//            BrewerydbAPIClient.getBeerBrewery(beer: beer, completion: { (newBeer) in
//                self.currentBeer.append(newBeer)
//                completion(newBeer)
//            })
//        }
//    }
    
    func searchBeers(name: String, completion: @escaping ([Beer]) -> ()) {
        BrewerydbAPIClient.searchBeer(name: name) { (beers) in
            self.currentBeer = beers
            completion(beers)
        }
    }
    
    func searchBreweries(name: String, completion: @escaping () -> ()) {
        BrewerydbAPIClient.searchBrewery(name: name) { (id, name) in
            BrewerydbAPIClient.getBreweryLocation(id: id, name: name, completion: { (brewery) in
                guard let brewery = brewery else {return}
                BrewerydbAPIClient.getBeersForBrewery(brewery: brewery, completion: { (beers) in
                    self.currentBreweryBeers = beers
                    completion()
                })
            })
            
        }
    }
    
//    func getBreweryBeers(name: String, completion: @escaping () -> ()) {
//        currentBreweryBeers.removeAll()
//        BrewerydbAPIClient.getBreweryID(name: name) { (id, brewery) in
//            BrewerydbAPIClient.getBeersForBrewery(id: id, brewery: brewery, completion: { (beers) in
//                self.currentBreweryBeers = beers
//                completion()
//            })
//        }
//    }
    
    func getBreweries(latitude: Double, longitude: Double, radius: Int, completion: @escaping () -> ()) {
        BrewerydbAPIClient.getBreweryByLocation(latitude: latitude, longitude: longitude, radius: radius) { (breweries) in
            self.breweries = breweries
            completion()
        }
    }
}
