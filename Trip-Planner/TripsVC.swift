//
//  TripsVC.swift
//  Trip-Planner
//
//  Created by djchai on 12/7/17.
//  Copyright © 2017 Phyllis Wong. All rights reserved.
//

import UIKit

class TripsVC: UIViewController, UITableViewDelegate {
    
    // Variables
    var trips = [Trip?]()
    var user: User?
    
    // Outlets
    
    @IBOutlet weak var tripsTableView: UITableView!
    
    // Actions

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tripsTableView.delegate = self
        tripsTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let currentUser = user else { return }
        print(user ?? "ERROR")
        
        Networking.fetch(route: Route.trips(), user: currentUser, httpMethod: .get) { (data, response) in
            print("Current status: \(data) \(response)")
            let trips = try? JSONDecoder().decode([Trip].self, from: data)
            
            guard let allTrips = trips else { return }
            self.trips = allTrips
            
            DispatchQueue.main.async {
                self.tripsTableView.reloadData()
            }
        }
    }
}

extension TripsVC:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trip = trips[indexPath.row]
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        // ~~~~~~~~~~~ CREATE THIS VIEW in the storyboard NEXT ~~~~~~~~~~~~~
        let tripDetailVC = storyboard.instantiateViewController(withIdentifier: "TripDetailVC") as! TripDetailVC
        
        tripDetailVC.trip = trip
//        tripDetailVC.user = user
        self.navigationController?.pushViewController(tripDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath) as! TripCell
        let trip = trips[indexPath.row]
        
        print(trip!)
        return cell
    }
}























