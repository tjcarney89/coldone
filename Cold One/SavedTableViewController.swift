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
        tabBarItem.title = "Saved Beers"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cdStore.savedBrews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as! SavedBeerCell
        let currentBrew = cdStore.savedBrews[indexPath.row]
        cell.savedBeerView.brew = currentBrew
        cell.savedBeerView.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currentBrew = cdStore.savedBrews[indexPath.row]
            cdStore.savedBrews.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            cdStore.deleteBrew(brew: currentBrew)
        }
    }
}

extension SavedTableViewController {
    func reloadData() {
        cdStore.fetchData()
        tableView.reloadData()
    }
}
