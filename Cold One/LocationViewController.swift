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
    
    
    let store = BeerDataStore.shared
    var locationManager: CLLocationManager!
    var latitude = Double()
    var longitude = Double()
    
    var radiusArray = [1, 5, 10, 20, 50, 100]
    var selectedRadius = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        breweryTableView.delegate = self
        breweryTableView.dataSource = self
        radiusPickerView.delegate = self
        radiusPickerView.dataSource = self
        determineLocation()
        
        // Do any additional setup after loading the view.
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
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(radiusArray[row])
    }
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
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        store.getBreweries(latitude: latitude, longitude: longitude, radius: selectedRadius, completion: {
            DispatchQueue.main.async {
                self.breweryTableView.reloadData()
            }
        })
    }
    

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "breweryBeerSegue" {return}
        if let destVC = segue.destination as? BreweryBeerTableViewController, let indexPath = breweryTableView.indexPathForSelectedRow {
            let selectedBrewery = store.breweries[indexPath.row]
            destVC.brewery = selectedBrewery
            
        }

    }
    

}