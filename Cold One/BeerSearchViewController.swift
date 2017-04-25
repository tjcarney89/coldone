//
//  BeerSearchViewController.swift
//  Cold One
//
//  Created by TJ Carney on 4/25/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class BeerSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var beerSearchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    let store = BeerDataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beerSearchBar.delegate = self
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let search = searchBar.text {
            print("SEARCH: \(search)")
            store.getBeer(name: search, completion: { (beer) in
                DispatchQueue.main.async {
                    self.searchResultsTableView.reloadData()
                }
            })
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.currentBeer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultsTableView.dequeueReusableCell(withIdentifier: "singleBeerCell", for: indexPath) as! BeerCell
        let currentBeer = store.currentBeer[indexPath.row]
        cell.beerView.beer = currentBeer
        return cell
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "beerDetailSegue" {return}
        if let destVC = segue.destination as? BeerDetailViewController, let indexPath = searchResultsTableView.indexPathForSelectedRow {
            let selectedBeer = store.currentBeer[indexPath.row]
            destVC.beer = selectedBeer
            
        }
        
    }
    

}
