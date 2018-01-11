//
//  TripCell.swift
//  Trip-Planner
//
//  Created by Phyllis Wong on 12/7/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

class TripCell: UITableViewCell {
    
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var waypointLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    
    var trip: Trip? {
       
        didSet {
            let destination = trip?.destination
            let waypoints = trip?.waypoints.description
            let completed = trip?.completed.description
            destinationLabel.text = "Destination: \(destination ?? "No destination")"
            waypointLabel.text = "Waypoints: \(waypoints ?? "No waypoints")"
            completedLabel.text = "Completed: \(completed ?? "False")"
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
