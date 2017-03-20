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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTrip))
    }
    
    func addTrip(_ sender : UIBarButtonItem){
        performSegue(withIdentifier: "createTrip", sender: UIBarButtonItem())
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let trips = self.trips{
            if (trips.count) > 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell") as! LabelCell
                cell.label.text! = trips[indexPath.row].tripName!
                return cell
            }
        }
        return UITableViewCell()
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
