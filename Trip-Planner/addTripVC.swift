//
//  addTripVC.swift
//  Trip-Planner
//
//  Created by djchai on 12/10/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

class addTripVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var destinationTF: UITextField!
    @IBOutlet weak var waypointsTF: UITextField!
    @IBOutlet weak var completedTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // When the user presses this button, it saves the trip.
    @IBAction func saveButton(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
