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
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addSelected))
    }
    
    func addSelected(sender : UIBarButtonItem){
        
        
        
        performSegueWithIdentifier("createTrip", sender: UIBarButtonItem())
    }
    

}
