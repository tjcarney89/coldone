//
//  SearchViewController.swift
//  Cold One
//
//  Created by TJ Carney on 4/24/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var beerSearchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var breweryLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var pourButton: UIButton!
    
    let store = BeerDataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beerSearchBar.delegate = self
        hideLabels()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        hideLabels()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let search = searchBar.text {
            print("SEARCH: \(search)")
            store.getBeer(name: search, completion: { (beer) in
                DispatchQueue.main.async {
                    self.unhideLabels()
                    self.nameLabel.text = beer.name
                    self.breweryLabel.text = "Brewed by \(beer.brewery)"
                    self.styleLabel.text = "Style: \(beer.style)"
                    self.abvLabel.text = "ABV: \(beer.abv)"
                }
            })
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    @IBAction func pourButtonTapped(_ sender: Any) {
    }
    
    func hideLabels() {
        nameLabel.isHidden = true
        breweryLabel.isHidden = true
        styleLabel.isHidden = true
        abvLabel.isHidden = true
        saveButton.isHidden = true
        pourButton.isHidden = true
    }
    
    func unhideLabels() {
        nameLabel.isHidden = false
        breweryLabel.isHidden = false
        styleLabel.isHidden = false
        abvLabel.isHidden = false
        saveButton.isHidden = false
        pourButton.isHidden = false
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
