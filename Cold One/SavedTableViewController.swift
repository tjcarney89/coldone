//
//  SavedTableViewController.swift
//  Cold One
//
//  Created by TJ Carney on 4/24/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class SavedTableViewController: UITableViewController, BeerDelegate {
    
    let store = BeerDataStore.shared
    let cdStore = CoreDataStack.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        cdStore.fetchData()

    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cdStore.savedBrews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as! SavedBeerCell
        let currentBrew = cdStore.savedBrews[indexPath.row]
        cell.savedBeerView.brew = currentBrew
        cell.savedBeerView.delegate = self

        // Configure the cell...

        return cell
    }
    
}

extension SavedTableViewController {
    func reloadData() {
        cdStore.fetchData()
        tableView.reloadData()
    }
}
