//
//  ItmeLocation.swift
//  TideTest
//
//  Created by Vlad-Constantin Buhaescu on 09/08/2017.
//  Copyright © 2017 Vlad-Constantin Buhaescu. All rights reserved.
//

import UIKit
import ObjectMapper

class ItemLocation: NSObject,Mappable {
    
    var lat:String?
    var long:String?
    
    public required init?(map: Map) {
    }
    // Mappable
    public func mapping(map: Map) {
        
        lat <- map["lat"]
        long <- map["lng"]
    }
    
}
