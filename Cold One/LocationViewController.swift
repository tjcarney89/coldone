//
//  LocationViewController.swift
//  Cold One
//
//  Created by TJ Carney on 4/26/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    
    
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        determineLocation()
        // Do any additional setup after loading the view.
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
        locationManager.stopUpdatingLocation()
        BrewerydbAPIClient.getBreweryByLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, radius: 10) { (breweries) in
            print("BREWERIES: \(breweries)")
        }
        print("LATITUDE: \(userLocation.coordinate.latitude)")
        print("LONGITUDE: \(userLocation.coordinate.longitude)")
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
