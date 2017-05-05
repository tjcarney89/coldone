//
//  LocationViewController.swift
//  Cold One
//
//  Created by TJ Carney on 4/26/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var breweryTableView: UITableView!
    @IBOutlet weak var radiusPickerView: UIPickerView!
    @IBOutlet weak var searchbutton: UIButton!
    
    
    let store = BeerDataStore.shared
    
    var locationManager: CLLocationManager!
    var latitude = Double()
    var longitude = Double()
    
    var radiusArray = [1, 5, 10, 20, 50, 100]
    var selectedRadius = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Breweries Near Me"
        breweryTableView.delegate = self
        breweryTableView.dataSource = self
        radiusPickerView.delegate = self
        radiusPickerView.dataSource = self
        determineLocation()
        setUpSearchButton()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.breweries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = breweryTableView.dequeueReusableCell(withIdentifier: "breweryListCell", for: indexPath) as! BreweryCell
        let currentBrewery = store.breweries[indexPath.row]
        cell.breweryView.brewery = currentBrewery
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let titleLabel = UILabel()
        let titleData = String(radiusArray[row])
        let title = NSAttributedString(string: titleData, attributes: [NSForegroundColorAttributeName: UIColor(red: 205/255, green: 100/255, blue: 40/255, alpha: 1.0), NSFontAttributeName: UIFont(name: "Beer", size: 17)!])
        titleLabel.attributedText = title
        titleLabel.textAlignment = .center
        return titleLabel
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return String(radiusArray[row])
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRadius = radiusArray[row] as Int
    }
    
    func determineLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation
        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        locationManager.stopUpdatingLocation()
    }
    
    func setUpSearchButton() {
        searchbutton.layer.borderColor = UIColor(red: 225/255, green: 214/255, blue: 15/255, alpha: 1.0).cgColor
        searchbutton.layer.cornerRadius = 10
        searchbutton.layer.borderWidth = 2
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        store.getBreweries(latitude: latitude, longitude: longitude, radius: selectedRadius, completion: {
            DispatchQueue.main.async {
                self.breweryTableView.reloadData()
            }
        })
    }
    

    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "breweryBeerSegue" {return}
        if let destVC = segue.destination as? BreweryBeerViewController, let indexPath = breweryTableView.indexPathForSelectedRow {
            let selectedBrewery = store.breweries[indexPath.row]
            destVC.brewery = selectedBrewery
            destVC.hidesBottomBarWhenPushed = true
        }
    }
}
