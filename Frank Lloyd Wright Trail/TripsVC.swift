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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSelected))
    }
    
    func addSelected(_ sender : UIBarButtonItem){
        
        
        
        performSegue(withIdentifier: "createTrip", sender: UIBarButtonItem())
    }
    

}
