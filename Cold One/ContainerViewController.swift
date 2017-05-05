//
//  ContainerViewController.swift
//  Cold One
//
//  Created by TJ Carney on 5/4/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    
    @IBOutlet weak var searchSegmentedControl: UISegmentedControl!
    @IBOutlet weak var beerSearchView: UIView!
    @IBOutlet weak var brewerySearchView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search by Beer"
        searchSegmentedControl.selectedSegmentIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func segmentedValueChanged(_ sender: Any) {
        switch searchSegmentedControl.selectedSegmentIndex {
        case 0:
            beerSearchView.isHidden = false
            brewerySearchView.isHidden = true
            navigationItem.title = "Search by Beer"
            break
        case 1:
            beerSearchView.isHidden = true
            brewerySearchView.isHidden = false
            navigationItem.title = "Search by Brewery"

            break
        default:
            break
        }
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
