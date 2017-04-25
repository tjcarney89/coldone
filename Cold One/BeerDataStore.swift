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
    
    func getBeer(name: String, completion: @escaping (Beer) -> ()) {
        BrewerydbAPIClient.getBeer(name: name) { (beer) in
            BrewerydbAPIClient.getBeerBrewery(beer: beer, completion: { (newBeer) in
                print("BEER: \(newBeer)")
                completion(newBeer)
            })
        }

    }
    
    func getBreweryBeers(name: String, completion: @escaping () -> ()) {
        currentBreweryBeers.removeAll()
        BrewerydbAPIClient.getBreweryID(name: name) { (id) in
            BrewerydbAPIClient.getBeersForBrewery(id: id, completion: { (beers) in
                self.currentBreweryBeers = beers
                completion()
            })
        }
    }
}
