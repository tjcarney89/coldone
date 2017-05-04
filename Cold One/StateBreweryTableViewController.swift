//
//  StateBreweryTableViewController.swift
//  Cold One
//
//  Created by TJ Carney on 5/2/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class StateBreweryTableViewController: UITableViewController {
    
    var breweries = [Brewery]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("6. Got those breweries: \(breweries)")
    }


    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return breweries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateBreweryCell", for: indexPath) as! BreweryCell
        let currentBrewery = breweries[indexPath.row]
        cell.stateBreweryView.brewery = currentBrewery
        return cell
    }
    

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "breweryBeerSegue" {return}
        if let destVC = segue.destination as? BreweryBeerViewController, let indexPath = tableView.indexPathForSelectedRow {
            let selectedBrewery = breweries[indexPath.row]
            destVC.brewery = selectedBrewery
        }
    }
}
