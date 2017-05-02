//
//  StateDetailTableViewController.swift
//  Cold One
//
//  Created by TJ Carney on 5/2/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class StateDetailTableViewController: UITableViewController {
    
    var state: USState?
    var brews = [Brew]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("BREWS: \(brews)")
        print("COUNT: \(brews.count)")
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return brews.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateDetailCell", for: indexPath) as! PouredBeerCell
        let currentBrew = brews[indexPath.row]
        print("CURRENT BREW: \(currentBrew)")
        cell.beerStateView.brew = currentBrew
        return cell
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
