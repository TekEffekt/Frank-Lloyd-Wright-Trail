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
        trips = trips?.sorted(byKeyPath: "tripName", ascending: true)
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
                cell.tripName.text! = "Trip (No Name)"
                cell.accessoryType = .none
            } else {
                cell.tripName.text! = trips[indexPath.row].tripName
                print("cellForRowAt: \(cell.tripName)")
                cell.accessoryType = .none
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let trips = self.trips {
            trip = trips[indexPath.row]
            //if all sitestops have times filled in, go straight to tour sign up scene
            if trip.complete {
                //convert waypoint string to waypoint order int array
                let wayPoint = trip.wayPointOrder.characters.flatMap({Int(String($0))})
                
                let createTripVC = self.storyboard?.instantiateViewController(withIdentifier: "createTrip") as! CreateTripVC
                createTripVC.trip = trip
                let suggestionVC = self.storyboard?.instantiateViewController(withIdentifier: "suggestion") as! TimelineVC
                suggestionVC.trip = trip
                let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpVC
                signupVC.trip = trip
                signupVC.wayPointOrder = wayPoint
                createTripVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                suggestionVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                signupVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                self.navigationController?.pushViewController(createTripVC, animated: false)
                self.navigationController?.pushViewController(suggestionVC, animated: false)
                self.navigationController?.pushViewController(signupVC, animated: false)
                
            } else {
                performSegue(withIdentifier: "createTrip", sender: nil)
            }
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
                //tableView.reloadData()
            })
            
            ac.addAction(cancelAction)
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
        }
    }

}
