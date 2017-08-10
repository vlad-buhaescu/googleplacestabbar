//
//  ResultItem.swift
//  TideTest
//
//  Created by Vlad-Constantin Buhaescu on 09/08/2017.
//  Copyright © 2017 Vlad-Constantin Buhaescu. All rights reserved.
//

import UIKit
import ObjectMapper
import MapKit

class ResultItem: NSObject,Mappable,MKAnnotation {
    
    var geometry:Geometry?
    var name:String?
    var rating:Double?
    var vicinity:String?
    var distanceFromUser:Double?
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return coordinateCLLocation()
        }
    }
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return String(format: "Distance: %.2f meters", distanceFromUser!)
    }
    
    func coordinateCLLocation() -> CLLocationCoordinate2D {
        
        guard let latitude = geometry?.location?.lat,
        let longitude = geometry?.location?.long else { return CLLocationCoordinate2D.init(latitude: 0, longitude: 0) }
        
        return CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
    }
    
    public required init?(map: Map) {
    }
    // Mappable
    public func mapping(map: Map) {
        
        geometry <- map["geometry"]
        name <- map["name"]
        rating <- map["rating"]
        vicinity <- map["vicinity"]
    }
    
    // annotation callout opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: [:])
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
}
