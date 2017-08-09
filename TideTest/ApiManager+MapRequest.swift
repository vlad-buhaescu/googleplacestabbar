//
//  File.swift
//  TideTest
//
//  Created by Vlad-Constantin Buhaescu on 09/08/2017.
//  Copyright © 2017 Vlad-Constantin Buhaescu. All rights reserved.
//

import Foundation
import Alamofire

let supplymentaryUrl = ""

extension ApiManager {
    
    func getBarsList(succesBlock: @escaping SuccesBlockAny,failureBlock: @escaping FailureBlock)  {
        
        ApiManager.sharedInstance.basicAPICall(.get, complementaryURL: supplymentaryUrl, parameters: [:], succesBlock: { (resultDict) in
            
            if let data = resultDict.data {
                
            } else {
                print("parsing error in \(type(of: self)) ")
                failureBlock(ErrorReason.failedParsingJSON)
            }
            
        }) { (error) in
            failureBlock(error)
        }
        
    }
}
