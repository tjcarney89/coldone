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
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var pourButton: UIButton!
    
    
    
    
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
        saveButton.isHidden = true
        pourButton.isHidden = true
        if let beer = beer {
            let alert = UIAlertController(title: "Beer Saved!", message: "\(beer.name) has been added to your saved beers", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true)

            let newBrew = cdStore.makeBrew(beer: beer)
            newBrew.isSaved = true
            cdStore.savedBrews.append(newBrew)
            cdStore.saveContext()
        }
    }
    

    @IBAction func pourButtonTapped(_ sender: Any) {
        saveButton.isHidden = true
        pourButton.isHidden = true
        if let beer = beer, let brewery = beer.brewery {
            let alert = UIAlertController(title: "Beer Poured!", message: "\(beer.name) has been added to your poured beers", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true)
            let newBrew = cdStore.makeBrew(beer: beer)
            for state in cdStore.states {
                if brewery.state.name == state.name {
                    newBrew.usstate = state
                }
            }
            newBrew.usstate?.isFilled = true
            newBrew.isSaved = false
            newBrew.isPoured = true
            cdStore.pouredBrews.append(newBrew)
            cdStore.saveContext()
        }
    }
}
