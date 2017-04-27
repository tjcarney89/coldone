//
//  Brewery.swift
//  Cold One
//
//  Created by TJ Carney on 4/24/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import Foundation
import SwiftyJSON

class Brewery {
    
    var id = String()
    var name = String()
    var locality: String?
    var region = String()
    var type = String()
    var address: String?
    var beers = [Beer]()
    var distance = Double()
    var hasAddress: Bool {
        if address == nil {
            return false
        } else {
            return true
        }
    }
    var hasLocality: Bool {
        if locality == nil {
            return false
        } else {
            return true
        }
    }
        
    init(name: String, id: String, locality: String?, region: String, type: String, address: String?, distance: Double) {
        self.name = name
        self.id = id
        self.locality = locality
        self.region = region
        self.type = type
        self.address = address
        self.distance = distance
    }
    
}

extension Brewery: CustomStringConvertible {
    var description: String {
        if let address = self.address {
            return "NAME: \(name), ADDRESS: \(address), \(locality), \(region), TYPE: \(type), DISTANCE: \(distance) miles"
        } else {
            return "NAME: \(name), ADDRESS: \(locality), \(region), TYPE: \(type), DISTANCE: \(distance) miles"
        }
    }
}
