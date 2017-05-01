//
//  State.swift
//  Cold One
//
//  Created by TJ Carney on 5/1/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import Foundation

class State {
    let name: String
    var abbreviation: String {
        switch name {
        case "Alaska":
            return "AK"
        case "Alabama":
            return "AL"
        case "Arkansas":
            return "AR"
        case "American Samoa":
            return "AS"
        case "Arizona":
            return "AZ"
        case "California":
            return "CA"
        case "Colorado":
            return "CO"
        case "Connecticut":
            return "CT"
        case "District of Columbia":
            return "DC"
        case "Delaware":
            return "DE"
        case "Florida":
            return "FL"
        case "Georgia":
            return "GA"
        case "Guam":
            return "GU"
        case "Hawaii":
            return "HI"
        case "Iowa":
            return "IA"
        case "Idaho":
            return "ID"
        case "Illinois":
            return "IL"
        case "Indiana":
            return "IN"
        case "Kansas":
            return "KS"
        case "Kentucky":
            return "KY"
        case "Louisiana":
            return "LA"
        case "Massachusetts":
            return "MA"
        case "Maryland":
            return "MA"
        case "Maine":
            return "ME"
        case "Michigan":
            return "MI"
        case "Minnesota":
            return "MN"
        case "Missouri":
            return "MO"
        case "Mississippi":
            return "MS"
        case "Montana":
            return "MT"
        case "North Carolina":
            return "NC"
        case "North Dakota":
            return "ND"
        case "Nebraska":
            return "NE"
        case "New Hampshire":
            return "NJ"
        case "New Jersey":
            return "NJ"
        case "New Mexico":
            return "NM"
        case "Nevada":
            return "NV"
        case "New York":
            return "NY"
        case "Ohio":
            return "OH"
        case "Oklahoma":
            return "OH"
        case "Oregon":
            return "OR"
        case "Pennsylvania":
            return "PA"
        case "Puerto Rico":
            return "PR"
        case "Rhode Island":
            return "RI"
        case "South Carolina":
            return "SC"
        case "South Dakota":
            return "SD"
        case "Tennessee":
            return "TN"
        case "Texas":
            return "TX"
        case "Utah":
            return "UT"
        case "Virginia":
            return "VA"
        case "Virgin Islands":
            return "VI"
        case "Vermont":
            return "VT"
        case "Washington":
            return "WA"
        case "Wisconsin":
            return "WI"
        case "West Virginia":
            return "WV"
        case "Wyoming":
            return "WY"
        default:
            return "N/A"
        }
    }
    var isFilled = false
    
    init(name: String) {
        self.name = name
    }
    
    init() {
        self.name = "Default"
    }
}
