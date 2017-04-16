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
    var trips = RealmQuery.queryTrips()
    var trip = Trip()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trip = Trip()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTrip))
    }
    
    func addTrip(_ sender : UIBarButtonItem){
        trip = Trip()
        trip.id = trip.incrementID()
        RealmWrite.add(trip: self.trip)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell") as! TripLabelCell
        if let trips = self.trips{
            if trips[indexPath.row].tripName == "" {
                cell.tripName.text! = "Trip"
                cell.accessoryType = .none
            } else {
                cell.tripName.text! = trips[indexPath.row].tripName
                cell.accessoryType = .none
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let trips = self.trips {
        trip = trips[indexPath.row]
        performSegue(withIdentifier: "createTrip", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let createTrip = segue.destination as! CreateTripVC
        createTrip.trip = trip
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let trip = trips![indexPath.row].tripName
            
            let title = "Delete \(trip)?"
            let message = "Are you sure you want to delete this trip?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                //remove item from the store
                RealmDelete.deleteTrip(index: indexPath.row, trips: self.trips!)
                //also remove
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
            ac.addAction(cancelAction)
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
        }
    }

}
