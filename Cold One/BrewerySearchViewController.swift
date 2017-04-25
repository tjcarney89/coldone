//
//  BrewerySearchViewController.swift
//  Cold One
//
//  Created by TJ Carney on 4/24/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class BrewerySearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var brewerySearchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    let store = BeerDataStore.shared
    

    override func viewDidLoad() {
        super.viewDidLoad()
        brewerySearchBar.delegate = self
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let search = brewerySearchBar.text {
            store.getBreweryBeers(name: search, completion: {
                DispatchQueue.main.async {
                    self.searchResultsTableView.reloadData()
                }
                
            })
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        store.currentBreweryBeers.removeAll()
        searchResultsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.currentBreweryBeers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultsTableView.dequeueReusableCell(withIdentifier: "breweryCell", for: indexPath) as! BeerCell
        let currentBeer = store.currentBreweryBeers[indexPath.row]
        cell.beerView.beer = currentBeer
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
