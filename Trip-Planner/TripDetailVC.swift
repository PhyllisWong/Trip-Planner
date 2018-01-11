//
//  TripDetailVC.swift
//  Trip-Planner
//
//  Created by Phyllis Wong on 12/7/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

class TripDetailVC: UIViewController {
    
    // Variables
    var trip : Trip?
    var user : User?
    
    // Outlets
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var waypointLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    
    
    // Actions

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let destination = trip?.destination
        let waypoints = trip?.waypoints.description
        let completed = trip?.completed.description
        
        destinationLabel.text = "\(destination ?? "No destination")"
        waypointLabel.text = "\(waypoints ?? "No waypoints")"
        completedLabel.text = "\(completed ?? "False")"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
