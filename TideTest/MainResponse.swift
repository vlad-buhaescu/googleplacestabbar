//
//  MainResponse.swift
//  TideTest
//
//  Created by Vlad-Constantin Buhaescu on 09/08/2017.
//  Copyright © 2017 Vlad-Constantin Buhaescu. All rights reserved.
//

import UIKit
import ObjectMapper

class MainResponse: NSObject,Mappable {
    
    var results:String?
    var status:String?
    
    public required init?(map: Map) {
    }
    // Mappable
    public func mapping(map: Map) {
        
        results <- map["results"]
        status <- map["status"]
    }
    
}
