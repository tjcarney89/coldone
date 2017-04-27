//
//  Beer.swift
//  Cold One
//
//  Created by TJ Carney on 4/24/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import Foundation
import SwiftyJSON

class Beer {
    
    var id = String()
    var name = String()
    var abv = String()
    var style = String()
    var brewery: String = "No Brewery"
    
//    init(dict: JSON) {
//        let idArray = dict["data"].arrayValue.map({$0["id"].stringValue})
//        let nameArray = dict["data"].arrayValue.map({$0["name"].stringValue})
//        let abvArray = dict["data"].arrayValue.map({$0["abv"].stringValue})
//        let styleArray = dict["data"].arrayValue.map({$0["style"]["name"].stringValue})
//        guard let id = idArray.first, let name = nameArray.first, let abv = abvArray.first, let style = styleArray.first else {return}
//        self.id = id
//        self.name = name
//        self.abv = abv
//        self.style = style
//    }
//    
    
    init(name: String, id: String, abv: String, style: String, brewery: String) {
        self.name = name
        self.id = id
        self.abv = abv
        self.style = style
        self.brewery = brewery
    }
}

extension Beer: CustomStringConvertible {
    var description: String {
        return "Name: \(name), ID: \(id), ABV: \(abv), Style: \(style), Brewery: \(brewery)"
    }
}
