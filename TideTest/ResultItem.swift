//
//  ResultItem.swift
//  TideTest
//
//  Created by Vlad-Constantin Buhaescu on 09/08/2017.
//  Copyright © 2017 Vlad-Constantin Buhaescu. All rights reserved.
//

import UIKit
import ObjectMapper

class ResultItem: NSObject,Mappable {
    
    var geometry:Geometry?
    var name:String?
    var rating:Double?
    var vicinity:String?
    var distanceFromUser:Double?
   
    public required init?(map: Map) {
    }
    // Mappable
    public func mapping(map: Map) {
        
        geometry <- map["geometry"]
        name <- map["name"]
        rating <- map["rating"]
        vicinity <- map["vicinity"]
    }
    
}
