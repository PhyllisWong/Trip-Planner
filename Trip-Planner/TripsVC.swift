//  TripsVC.swift
//  Trip-Planner
//  Created by Phyllis Wong on 12/7/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.

import UIKit

class TripsVC: UIViewController,  UITableViewDelegate  {
    
    // Variables
    // var user: User?
    var trips = [Trip?]()
    var user = User(email: "test@test.com", username: "test", password: "test")
    
    // Outlets
    @IBOutlet weak var tripsTableView: UITableView!
    
    // Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trips"
        
        // set the row height for the tableView large enough to display all the data
        tripsTableView.rowHeight = UITableViewAutomaticDimension
        tripsTableView.rowHeight = 120
        
        // Set the delegate of the table view to the view controller
        tripsTableView.delegate = self
        tripsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // http GET request
        Networking.fetch(route: Route.getTrips) { (data, response) in
            print("Networking fetch trips results:\nResponse code: \(response)\n")
            let trips = try? JSONDecoder().decode([Trip].self, from: data)
            
            print("Current trips: \(trips!)\n")
            
            guard let allTrips = trips else { return }
            self.trips = allTrips
            
            DispatchQueue.main.async {
                self.tripsTableView.reloadData()
            }
        }
    }
    
    
}

extension TripsVC: UITableViewDataSource {
    
    // When user selects a row in the table view go to the detail view of the trip
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trip = trips[indexPath.row]!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let tripDetailVC = storyboard.instantiateViewController(withIdentifier: "TripDetailVC") as! TripDetailVC
        
        tripDetailVC.trip = trip
        tripDetailVC.user = user
        
        self.navigationController?.pushViewController(tripDetailVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath) as! TripCell
        let trip = trips[indexPath.row]
        cell.trip = trip
        return cell
    }
    
    // Deleting a row the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let deleteTrip = trips[indexPath.row] else {
                return 
            }
            print("Trip to delete: \(deleteTrip)\n")
            
            // Delete data from the array of Trips
            self.trips.remove(at: indexPath.row)
            
            //Delete the row from the tableview
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // http DELETE request to remove from the database
            Networking.fetch(route: Route.deleteTrip(destination: deleteTrip.destination)) { (data, response)  in
                
                // Reloads tableview data if successful
                let statusCode = response
                switch statusCode {
                case 200...299:
                    print("success: \(statusCode)\n")
                    DispatchQueue.main.async {
                        tableView.reloadData()
                    }
                default:
                    print("failure: \(statusCode)\n")
                }
            }
        }
    }
}
