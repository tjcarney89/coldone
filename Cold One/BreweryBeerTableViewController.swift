//
//  BreweryBeerTableViewController.swift
//  Cold One
//
//  Created by TJ Carney on 4/26/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class BreweryBeerTableViewController: UITableViewController {
    
    let store = BeerDataStore.shared
    let loadingView = UIView()
    let loadingLabel = UILabel()
    
    var brewery: Brewery?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLoadingView()
        setUpLoadingLabel()
        getBeers()

    }
    
    func getBeers() {
        if let brewery = brewery {
            store.getBreweryBeers(name: brewery.name) {
                DispatchQueue.main.async {
                    self.loadingView.removeFromSuperview()
                    self.tableView.reloadData()
                    print("RELOADED DATA")
                    if self.store.currentBreweryBeers.count == 0 {
                        let myAlert = UIAlertController(title: "No Beer!", message: "Sorry, no beers found for this brewery", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                        myAlert.addAction(okAction)
                        self.present(myAlert, animated: true)
                        print("NO BEERS")
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return store.currentBreweryBeers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breweryBeerCell", for: indexPath) as! BeerCell
        let currentBeer = store.currentBreweryBeers[indexPath.row]
        cell.breweryBeerView.beer = currentBeer
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "beerDetailSegue" {return}
        if let destVC = segue.destination as? BeerDetailViewController, let indexPath = tableView.indexPathForSelectedRow {
            let selectedBeer = store.currentBreweryBeers[indexPath.row]
            destVC.beer = selectedBeer
            
        }
        
    }
    
    
    func setUpLoadingView() {
        tableView.addSubview(loadingView)
        tableView.bringSubview(toFront: loadingView)
        loadingView.layer.borderColor = UIColor.black.cgColor
        loadingView.layer.borderWidth = 2
        loadingView.backgroundColor = UIColor.red
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        loadingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        loadingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
    }
    
    func setUpLoadingLabel() {
        loadingView.addSubview(loadingLabel)
        loadingLabel.text = "LOADING"
        loadingLabel.textAlignment = .center
        loadingLabel.font = UIFont(name: "Avenir-Heavy", size: 24)
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        loadingLabel.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        loadingLabel.heightAnchor.constraint(equalTo: loadingView.heightAnchor, multiplier: 0.3).isActive = true
        loadingLabel.widthAnchor.constraint(equalTo: loadingView.widthAnchor, multiplier: 0.4).isActive = true
    }

}
