//
//  BreweryBeerViewController.swift
//  Cold One
//
//  Created by TJ Carney on 4/27/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class BreweryBeerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var beerTableView: UITableView!
    
    let loadingView = UIView()
    let loadingLabel = UILabel()
    
    let store = BeerDataStore.shared
    let beerColor = UIColor(red: 209/255, green: 170/255, blue: 35/255, alpha: 1.0)
    
    var brewery: Brewery?

    override func viewDidLoad() {
        super.viewDidLoad()
        beerTableView.delegate = self
        beerTableView.dataSource = self
        beerTableView.isHidden = true
        setUpLoadingView()
        setUpLoadingLabel()
        getBeers()
    }
    
    func getBeers() {
        if let brewery = brewery {
            store.searchBreweries(name: brewery.name) {
                DispatchQueue.main.async {
                    self.beerTableView.reloadData()
                    self.loadingView.isHidden = true
                    self.beerTableView.isHidden = false
                    if self.store.currentBreweryBeers.count == 0 {
                        let myAlert = UIAlertController(title: "No Beer!", message: "Sorry, no beers found for this brewery", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                        myAlert.addAction(okAction)
                        self.present(myAlert, animated: true)
                    }
                }
            }
        }
    }


     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.currentBreweryBeers.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breweryBeerCell", for: indexPath) as! BeerCell
        let currentBeer = store.currentBreweryBeers[indexPath.row]
        cell.breweryBeerView.beer = currentBeer
        cell.selectionStyle = .none
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "beerDetailSegue" {return}
        if let destVC = segue.destination as? BeerDetailViewController, let indexPath = beerTableView.indexPathForSelectedRow {
            let selectedBeer = store.currentBreweryBeers[indexPath.row]
            destVC.beer = selectedBeer
            destVC.hidesBottomBarWhenPushed = true
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    func setUpLoadingView() {
        view.addSubview(loadingView)
        loadingView.layer.cornerRadius = 10
        loadingView.layer.borderColor = UIColor.white.cgColor
        loadingView.layer.borderWidth = 2
        loadingView.backgroundColor = beerColor
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        loadingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        loadingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
    }
    
    func setUpLoadingLabel() {
        loadingView.addSubview(loadingLabel)
        loadingLabel.text = "Loading Beers..."
        loadingLabel.textAlignment = .center
        loadingLabel.textColor = UIColor.white
        loadingLabel.font = UIFont(name: "Beer", size: 20)
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        loadingLabel.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        loadingLabel.heightAnchor.constraint(equalTo: loadingView.heightAnchor, multiplier: 0.35).isActive = true
        loadingLabel.widthAnchor.constraint(equalTo: loadingView.widthAnchor, multiplier: 0.7).isActive = true
    }
}
