//
//  TripCell.swift
//  Trip-Planner
//
//  Created by djchai on 12/7/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

class TripCell: UITableViewCell {
    
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var waypointLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    
    var trip: Trip? {
        didSet {
            
            destinationLabel.text = "Destination: \(trip?.destination)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
