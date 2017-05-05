//
//  StatesTableViewController.swift
//  Cold One
//
//  Created by TJ Carney on 5/1/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class StatesTableViewController: UITableViewController {
    
    let cdStore = CoreDataStack.sharedInstance
    let store = BeerDataStore.shared
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cdStore.fetchData()
        if cdStore.states.count == 0 {
            cdStore.makeStates()
        }
        
        for name in UIFont.familyNames {
            print(name)
            if let nameString = name as? String
            {
                print(UIFont.fontNames(forFamilyName: nameString))
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCounter()
        navigationItem.title = "States (\(counter)/50)"
        cdStore.fetchData()
        tableView.reloadData()
    }
    
    func updateCounter() {
        counter = 0
        for state in cdStore.states {
            if state.isFilled {
                counter += 1
            }
        }
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
        return cdStore.states.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath) as! StateCell
        let currentState = cdStore.states[indexPath.row]
        cell.stateView.state = currentState
        return cell
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "stateDetailSegue" {return}
        if let destVC = segue.destination as? StateDetailViewController, let indexPath = tableView.indexPathForSelectedRow {
            let selectedState = cdStore.states[indexPath.row]
            destVC.state = selectedState
            destVC.brews = selectedState.brews!.allObjects as! [Brew]
            destVC.brews.sort(by: { (brew1, brew2) -> Bool in
                brew1.isFavorite && !brew2.isFavorite
            })
            destVC.hidesBottomBarWhenPushed = true
            
        }

    }
    

}



