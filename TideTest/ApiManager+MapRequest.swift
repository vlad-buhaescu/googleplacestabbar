//
//  File.swift
//  TideTest
//
//  Created by Vlad-Constantin Buhaescu on 09/08/2017.
//  Copyright © 2017 Vlad-Constantin Buhaescu. All rights reserved.
//

import Foundation
import Alamofire

let locationUrl = "location="
let type = "&type="
extension ApiManager {
    
    func getBarsList(with Lat:Double,Long:Double,radius:Int,typeOfBusiness:String, succesBlock: @escaping SuccesBlockAny,failureBlock: @escaping FailureBlock)  {
        
        let complementaryURL = locationUrl + "\(Lat)," + "\(Long)" + "&radius=\(radius)" + type + typeOfBusiness
        
        ApiManager.sharedInstance.basicAPICall(.get, complementaryURL: complementaryURL, parameters: [:], succesBlock: { (resultDict) in
            
            if let data = resultDict.data {
                if let result = MainResponse(JSONString: String(data: data, encoding: .utf8)!) {
                    print("result of gmaps querry \(result)")
                    succesBlock(result)
                }
            } else {
                print("parsing error in \(type(of: self)) ")
                failureBlock(ErrorReason.failedParsingJSON)
            }
            
        }) { (error) in
            failureBlock(error)
        }
        
    }
}
