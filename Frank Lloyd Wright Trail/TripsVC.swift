//
//  CreateTripVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/13/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class TripsVC : UITableViewController{
    var trips: Results<Trip>?
    var trip = Trip()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trip = Trip()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        trips = RealmQuery.queryTrips()
        tableView.reloadData()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTrip))
    }
    
    func addTrip(_ sender : UIBarButtonItem){
        trip = Trip()
        performSegue(withIdentifier: "createTrip", sender: UIBarButtonItem())
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let trips = self.trips {
           return trips.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let trips = self.trips {
            if (trips.count) > 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell") as! LabelCell
                cell.label.text! = trips[indexPath.row].tripName!
                cell.accessoryType = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            RealmDelete.deleteTrip(index: indexPath.row, trips: trips!)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let trips = self.trips{
        trip = trips[indexPath.row]
        performSegue(withIdentifier: "createTrip", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let createTrip = segue.destination as! CreateTripVC
        createTrip.trip = trip
    }
    

}
