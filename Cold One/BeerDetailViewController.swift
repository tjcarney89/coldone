//
//  BeerDetailViewController.swift
//  Cold One
//
//  Created by TJ Carney on 4/25/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var breweryLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    
    var beer: Beer?
    
    let store = BeerDataStore.shared
    let cdStore = CoreDataStack.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let beer = beer, let brewery = beer.brewery {
            beerNameLabel.text = beer.name
            breweryLabel.text = "Brewed by \(brewery.name)"
            styleLabel.text = "Style: \(beer.style)"
            abvLabel.text = "ABV: \(beer.abv)"

        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        if let beer = beer {
            let context = cdStore.persistentContainer.viewContext
            let newBrew = cdStore.makeBrew(beer: beer)
            newBrew.isSaved = true
            cdStore.savedBrews.append(newBrew)
            cdStore.saveContext()
        }
    }
    

    @IBAction func pourButtonTapped(_ sender: Any) {
        if let beer = beer {
            let context = cdStore.persistentContainer.viewContext
            let newBrew = cdStore.makeBrew(beer: beer)
            newBrew.isSaved = false
            newBrew.isPoured = true
            cdStore.pouredBrews.append(newBrew)
            cdStore.saveContext()
        }
    }
}
