//
//  StateDetailViewController.swift
//  Cold One
//
//  Created by TJ Carney on 5/2/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class StateDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var stateDetailTableView: UITableView!
    @IBOutlet weak var noBeersLabel: UILabel!
    @IBOutlet weak var findBeersButton: UIButton!
    @IBOutlet weak var loadingLabel: UILabel!
    
    let store = BeerDataStore.shared
    var state: USState?
    var brews = [Brew]()
    var breweries = [Brewery]()


    override func viewDidLoad() {
        super.viewDidLoad()
        if brews.isEmpty {
            stateDetailTableView.isHidden = true
            self.setUpLabelAndButton()
            self.findBeersButton.isHidden = true
            guard let name = state?.name else {return}
            store.getBreweriesByState(state: name , completion: { (breweries) in
                DispatchQueue.main.async {
                    self.loadingLabel.isHidden = true
                    self.findBeersButton.isHidden = false
                    self.breweries = breweries
                }
            })
            
            
        }
        stateDetailTableView.delegate = self
        stateDetailTableView.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateDetailCell", for: indexPath) as! PouredBeerCell
        let currentBrew = brews[indexPath.row]
        cell.beerStateView.brew = currentBrew
        return cell
    }
    
    func setUpLabelAndButton() {
        if let name = state?.name {
            loadingLabel.text = "Hang on while we find you some!"
            noBeersLabel.text = "You have not tried any beers from \(name)!"
            findBeersButton.setTitle("See breweries in \(name)", for: .normal)
            
        }
        
    }

    @IBAction func findBreweriesButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "stateBrewerySegue", sender: self)
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "stateBrewerySegue" {return}
        if let destVC = segue.destination as? StateBreweryTableViewController {
            let filteredBreweries = breweries.filter { $0.type != "Production Facility" && $0.type != "Office" }
            destVC.breweries = filteredBreweries
            destVC.hidesBottomBarWhenPushed = true
        }
    }
    

}
