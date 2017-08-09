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
    
    fileprivate let baseURL = ""
    
    typealias SuccesBlock = (DataResponse<Any>) -> Void
    typealias FailureBlock = (Error!) -> Void
    
    func basicAPICall(_ type: Alamofire.HTTPMethod, complementaryURL: String, parameters: Dictionary<String,Any>, succesBlock: @escaping SuccesBlock, failureBlock: @escaping FailureBlock)    {
        
        let urlString: String = baseURL + complementaryURL as String
        
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
