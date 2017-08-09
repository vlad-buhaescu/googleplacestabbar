//
//  ViewController.swift
//  TideTest
//
//  Created by Vlad-Constantin Buhaescu on 09/08/2017.
//  Copyright © 2017 Vlad-Constantin Buhaescu. All rights reserved.
//

import UIKit
import GooglePlaces

class TableViewController: UIViewController {
    
    @IBOutlet weak var emptyStateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var resultsDataService: ResultsDataService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self.resultsDataService
        self.tableView.dataSource = self.resultsDataService
    }
    
    
    
}


