//
//  ViewController.swift
//  TideTest
//
//  Created by Vlad-Constantin Buhaescu on 09/08/2017.
//  Copyright © 2017 Vlad-Constantin Buhaescu. All rights reserved.
//

import UIKit
import GooglePlaces


class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var resultsDataService: ResultsDataService!
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self.resultsDataService
        self.tableView.dataSource = self.resultsDataService
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        determineMyCurrentLocation()
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.distanceFilter = 50
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
}

extension TableViewController:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        ApiManager.sharedInstance.getBarsList(with: userLocation.coordinate.latitude, Long: userLocation.coordinate.longitude, radius: 200,typeOfBusiness:"bar", succesBlock: { [weak self] (response) in
            
            if let main = response as? MainResponse,
                let results = main.results {
                
                for item in results {
                    
                    let userLocation = manager.location
                    
                    if let latitude = item.geometry?.location?.lat,
                          let longitude = item.geometry?.location?.long {
                        
                        let barLocation = CLLocation(latitude: latitude, longitude: longitude)
                        item.distanceFromUser = userLocation?.distance(from: barLocation)
                    }
                    
                }
                
                self?.resultsDataService.resultsDataSource = results
                self?.tableView.reloadData()
            }
            
            
        }) { (error) in
            print("error in \(#file) \(type(of: self)) \n \(error)")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}

