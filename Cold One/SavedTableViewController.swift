//
//  SavedTableViewController.swift
//  Cold One
//
//  Created by TJ Carney on 4/24/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class SavedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BeerDelegate {
    
    @IBOutlet weak var savedTableView: UITableView!
    
    let store = BeerDataStore.shared
    let cdStore = CoreDataStack.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        if cdStore.savedBrews.isEmpty {
            savedTableView.isHidden = true
        } else {
            savedTableView.isHidden = false
        }
        savedTableView.delegate = self
        savedTableView.dataSource = self
        cdStore.fetchData()
        navigationItem.title = "Saved Beers"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if cdStore.savedBrews.isEmpty {
            savedTableView.isHidden = true
        } else {
            savedTableView.isHidden = false
        }
        cdStore.fetchData()
        savedTableView.reloadData()
    }

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cdStore.savedBrews.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as! SavedBeerCell
        let currentBrew = cdStore.savedBrews[indexPath.row]
        cell.savedBeerView.brew = currentBrew
        cell.savedBeerView.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        savedTableView.reloadData()
    }
}
