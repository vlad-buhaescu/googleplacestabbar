//
//  File.swift
//  TideTest
//
//  Created by Vlad-Constantin Buhaescu on 09/08/2017.
//  Copyright © 2017 Vlad-Constantin Buhaescu. All rights reserved.
//

import Foundation
import Alamofire

enum ErrorReason: Error {
    
    case failedParsingJSON
    case failedToGetImageFromURL
    case requestFailed(reason: String)
}

typealias SuccesBlockAny = (AnyObject) -> Void

class ApiManager: NSObject {
    
    static let sharedInstance = ApiManager()
    
    // https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&type=restaurant&keyword=cruise&key=AIzaSyCb5Wa_lTCbzxRh8bZnm_Lh_yKHAQZxLms
    
    fileprivate let key = "&key=AIzaSyCb5Wa_lTCbzxRh8bZnm_Lh_yKHAQZxLms"
    
    fileprivate let baseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    
    typealias SuccesBlock = (DataResponse<Any>) -> Void
    typealias FailureBlock = (Error!) -> Void
    
    func basicAPICall(_ type: Alamofire.HTTPMethod, complementaryURL: String, parameters: Dictionary<String,Any>, succesBlock: @escaping SuccesBlock, failureBlock: @escaping FailureBlock)    {
        
        let urlString: String = baseURL + complementaryURL + key
        
        switch type {
        case .get:
            
            let dataRequest = Alamofire.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: [:] ).responseJSON { response in
                
                if response.response?.statusCode == 200 {
                    succesBlock(response)
                } else {
                    print("value of \(String(data: response.data!, encoding: .utf8)!)")
                    
                    failureBlock(response.error)
                }
            }
            
            dataRequest.resume()
            
            break
        default:
            break
        }
    }
}
