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
        if let beer = beer {
            beerNameLabel.text = beer.name
            breweryLabel.text = "Brewed by \(beer.brewery)"
            styleLabel.text = "Style: \(beer.style)"
            abvLabel.text = "ABV: \(beer.abv)"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
