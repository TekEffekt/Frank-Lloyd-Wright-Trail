//
//  CreateTripVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/13/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation

class TripsVC : UITableViewController{
   
    override func viewDidLoad() {
    super.viewDidLoad()
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
             TripModel.shared.type = "weekend"
             performSegueWithIdentifier("createTrip", sender: UIButton())
        case 1:
             TripModel.shared.type = "winter"
             performSegueWithIdentifier("createTrip", sender: UIButton())
        case 2:
             TripModel.shared.type = "tomorrow"
             performSegueWithIdentifier("createTrip", sender: UIButton())
        default:
            return
        }
    }
}
