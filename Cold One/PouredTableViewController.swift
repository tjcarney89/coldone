//
//  PouredTableViewController.swift
//  Cold One
//
//  Created by TJ Carney on 4/24/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class PouredTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var pouredTableView: UITableView!
    
    
    let store = BeerDataStore.shared
    let cdStore = CoreDataStack.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if cdStore.pouredBrews.isEmpty {
            pouredTableView.isHidden = true
        } else {
            pouredTableView.isHidden = false
        }
        pouredTableView.delegate = self
        pouredTableView.dataSource = self
        cdStore.fetchData()
        navigationItem.title = "Poured Beers"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if cdStore.pouredBrews.isEmpty {
            pouredTableView.isHidden = true
        } else {
            pouredTableView.isHidden = false
        }
        cdStore.fetchData()
        pouredTableView.reloadData()
    }

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cdStore.pouredBrews.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pouredCell", for: indexPath) as! PouredBeerCell
        let currentBrew = cdStore.pouredBrews[indexPath.row]
        cell.pouredBeerView.brew = currentBrew
        cell.selectionStyle = .none
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currentBrew = cdStore.pouredBrews[indexPath.row]
            cdStore.pouredBrews.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            cdStore.deleteBrew(brew: currentBrew)
        }
    }
}


