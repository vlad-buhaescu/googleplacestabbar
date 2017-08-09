//
//  ResultsDataService.swift
//  TideTest
//
//  Created by Vlad-Constantin Buhaescu on 09/08/2017.
//  Copyright © 2017 Vlad-Constantin Buhaescu. All rights reserved.
//

import UIKit

class ResultsDataService: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    var resultsDataSource:[ResultItem]?
    
    var thumbHidden:Bool = true
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let results = resultsDataSource else { return 0 }
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as! ResultTableViewCell
        
        if let resultItem = self.resultsDataSource?[indexPath.row] {
            cell.setupCell(resultItem:resultItem)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let resultItem = self.resultsDataSource?[indexPath.row],
            let location = resultItem.geometry?.location,
            let latitude = location.lat,
            let longitude = location.long {
            
            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
                
                UIApplication.shared.openURL(URL(string:"comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&q=\(latitude),\(longitude)")!)
                
            }
            
            
        }
        
        
    }
}

