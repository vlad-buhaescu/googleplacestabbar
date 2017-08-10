//
//  ResultTableViewCell.swift
//  TideTest
//
//  Created by Vlad-Constantin Buhaescu on 09/08/2017.
//  Copyright © 2017 Vlad-Constantin Buhaescu. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    static let identifier = "ResultCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var vicinityLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(resultItem:ResultItem)  {
        
        if let name = resultItem.name {
            self.nameLabel.text = "Name: \(name)"
        }
        
        if let rating = resultItem.rating {
            self.ratingLabel.text = "Rating: \(rating)"
        }
        
        if let vicinity = resultItem.vicinity {
            self.vicinityLabel.text = "Vicinity: \(vicinity)"
        }
        
        if let distance = resultItem.distanceFromUser {
            self.distanceLabel.text = String(format: "Distance: %.2f meters", distance)
        }
        
    }

}
