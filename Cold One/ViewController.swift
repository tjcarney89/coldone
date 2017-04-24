//
//  ViewController.swift
//  Cold One
//
//  Created by TJ Carney on 4/24/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        BrewerydbAPIClient.getBeer(name: "bud light") { (beer) in
            BrewerydbAPIClient.getBeerBrewery(beer: beer, completion: { (newBeer) in
                print("BEER: \(newBeer)")
            })
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

