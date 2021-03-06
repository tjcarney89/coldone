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
        searchResultsTableView.isHidden = true
        beerSearchBar.delegate = self
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        beerSearchBar.resignFirstResponder()
        if let search = searchBar.text {
            store.searchBeers(name: search, completion: { (beers) in
                DispatchQueue.main.async {
                    self.searchResultsTableView.isHidden = false
                    self.searchResultsTableView.reloadData()
                }
            })
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResultsTableView.isHidden = true
        store.currentBeer.removeAll()
        searchResultsTableView.reloadData()
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
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "beerDetailSegue" {return}
        if let destVC = segue.destination as? BeerDetailViewController, let indexPath = searchResultsTableView.indexPathForSelectedRow {
            let selectedBeer = store.currentBeer[indexPath.row]
            destVC.beer = selectedBeer
            destVC.hidesBottomBarWhenPushed = true
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
}
