//
//  PouredTableViewController.swift
//  Cold One
//
//  Created by TJ Carney on 4/24/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class PouredTableViewController: UITableViewController {
    
    let store = BeerDataStore.shared
    let cdStore = CoreDataStack.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cdStore.fetchData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cdStore.pouredBrews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pouredCell", for: indexPath) as! PouredBeerCell
        let currentBrew = cdStore.pouredBrews[indexPath.row]
        cell.pouredBeerView.brew = currentBrew
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currentBrew = cdStore.pouredBrews[indexPath.row]
            cdStore.pouredBrews.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            cdStore.deleteBrew(brew: currentBrew)
        }
    }
}


