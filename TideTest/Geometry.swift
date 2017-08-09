//
//  Geometry.swift
//  TideTest
//
//  Created by Vlad-Constantin Buhaescu on 09/08/2017.
//  Copyright © 2017 Vlad-Constantin Buhaescu. All rights reserved.
//

import UIKit
import ObjectMapper

class Geometry: NSObject,Mappable {
    
    var location:ItemLocation?
    
    public required init?(map: Map) {
    }
    // Mappable
    public func mapping(map: Map) {
        
        location <- map["location"]
    }
    
}
