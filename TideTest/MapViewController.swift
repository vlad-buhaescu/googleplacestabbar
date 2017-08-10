//
//  MapViewController.swift
//  TideTest
//
//  Created by Vlad-Constantin Buhaescu on 09/08/2017.
//  Copyright © 2017 Vlad-Constantin Buhaescu. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    var resultsDataSource:[ResultItem]?
    var location:CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let initialLocation = CLLocation(latitude: 51.4394453404025, longitude: -0.0454779488052179)
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func addAnnotationsForMap()  {
        if let annotations = resultsDataSource {
            mapView.addAnnotations(annotations)
        }
    }
 
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension MapViewController:MKMapViewDelegate {
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? ResultItem {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.pinTintColor = UIColor.init(colorLiteralRed: 217.0/255.0, green: 108.0/255.0, blue: 0, alpha: 1.0)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                let button = UIButton(type: .custom)
                button.setImage(#imageLiteral(resourceName: "compas"), for: UIControlState.normal)
                button.frame = CGRect.init(x: 0, y: 0, width: 25, height: 25)
                view.rightCalloutAccessoryView = button
            }
            return view
        }
        return nil
    }
    
    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let resultItem = view.annotation as? ResultItem,
            let location = resultItem.geometry?.location,
            let latitude = location.lat,
            let longitude = location.long {
            
            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
                UIApplication.shared.openURL(URL(string:"comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&q=\(latitude),\(longitude)")!)
            }
        }
    }

}
