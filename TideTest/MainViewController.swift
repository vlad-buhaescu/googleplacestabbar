//
//  MainViewController.swift
//  TideTest
//
//  Created by Vlad-Constantin Buhaescu on 09/08/2017.
//  Copyright © 2017 Vlad-Constantin Buhaescu. All rights reserved.
//

import UIKit
import SlidingContainerViewController
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet weak var containerForTabbed: UIView!
    var locationManager:CLLocationManager!
    var slidingContainerViewController:SlidingContainerViewController?
    var resultsDataSource:[ResultItem]?
    var tintBlue :UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Bars arround me"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.init(colorLiteralRed: 217.0/255.0, green: 108.0/255.0, blue: 0, alpha: 1.0)]
        
        self.tintBlue = UIColor.init(colorLiteralRed: 44.0/255.0, green: 56.0/255.0, blue: 114.0/255.0, alpha: 1.0)
        
        if let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "tableVC"),
            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "mapVC") {
            
            slidingContainerViewController = SlidingContainerViewController (
                parent: self,
                contentViewControllers: [vc1, vc2],
                titles: ["List", "Map"])
            slidingContainerViewController?.contentScrollView.scrollsToTop = true
            containerForTabbed.addSubview((slidingContainerViewController?.view)!)
            slidingContainerViewController?.sliderView.appearance.outerPadding = 0
            slidingContainerViewController?.sliderView.appearance.innerPadding = 50
            slidingContainerViewController?.sliderView.appearance.selectorColor = tintBlue!
            slidingContainerViewController?.sliderView.appearance.textColor = tintBlue!
            slidingContainerViewController?.sliderView.appearance.fixedWidth = true
            slidingContainerViewController?.delegate = self
        }
        
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
        }
    }
    
}

extension MainViewController:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        ApiManager.sharedInstance.getBarsList(with: userLocation.coordinate.latitude, Long: userLocation.coordinate.longitude, radius: 500,typeOfBusiness:"bar", succesBlock: { [weak self] (response) in
            
            if let main = response as? MainResponse,
                let results = main.results {
                
                self?.resultsDataSource = results
                
                for item in results {
                    
                    let userLocation = manager.location
                    
                    if let latitude = item.geometry?.location?.lat,
                        let longitude = item.geometry?.location?.long {
                        
                        let barLocation = CLLocation(latitude: latitude, longitude: longitude)
                        item.distanceFromUser = userLocation?.distance(from: barLocation)
                    }
                    
                }
                if let listVC = self?.slidingContainerViewController?.contentViewControllers.first as? TableViewController {
                    listVC.resultsDataService.resultsDataSource = results
                    listVC.tableView.reloadData()
                    
                }
                
                if let mapVC = self?.slidingContainerViewController?.contentViewControllers.last as? MapViewController {
                    mapVC.resultsDataSource = results
                    mapVC.centerMapOnLocation(location: userLocation)
                    mapVC.addAnnotationsForMap()
                }
                
            }
        }) { (error) in
            print("error in \(#file) \(type(of: self)) \n \(error)")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}

extension MainViewController: SlidingContainerViewControllerDelegate {
    
    func slidingContainerViewControllerDidMoveToViewController(_ slidingContainerViewController: SlidingContainerViewController, viewController: UIViewController, atIndex: Int) {
        
        if let listVC = viewController as? TableViewController {
            listVC.resultsDataService.resultsDataSource = self.resultsDataSource
            listVC.tableView.reloadData()
        }
        
        if let mapVC = viewController as? MapViewController {
            mapVC.resultsDataSource = self.resultsDataSource
            mapVC.centerMapOnLocation(location: self.locationManager.location!)
            mapVC.addAnnotationsForMap()
        }
    }
    
    func slidingContainerViewControllerDidShowSliderView(_ slidingContainerViewController: SlidingContainerViewController) {
        
    }
    
    func slidingContainerViewControllerDidHideSliderView(_ slidingContainerViewController: SlidingContainerViewController) {
        
    }
    
}
