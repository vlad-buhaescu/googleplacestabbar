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
    
    var geometry:String?
    var name:String?
    var rating:String?
    var vicinity:String?
   
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
