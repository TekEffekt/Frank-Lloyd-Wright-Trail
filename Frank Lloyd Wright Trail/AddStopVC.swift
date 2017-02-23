//
//  AddStopVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/19/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import UIKit

class AddStopVC: UITableViewController, UIPickerViewDelegate{
    private var pickerVisible = false
    var type: StopActions?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Add Stops"
        let button = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(doneSelected))
        
        self.navigationItem.rightBarButtonItem = button
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 4
        default:
            return 1
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            let cell = tableView.dequeueReusableCellWithIdentifier("name") as! NameCell
            return cell
        case (1,0):
            let cell = tableView.dequeueReusableCellWithIdentifier("label") as! LabelCell
            cell.label.text! = "Date"
            return cell
        case (1,1):
            let cell = tableView.dequeueReusableCellWithIdentifier("datePick") as! DatePickCell
            cell.datePicker.datePickerMode = .Date
            return cell
        case (2,0):
            let cell = tableView.dequeueReusableCellWithIdentifier("label") as! LabelCell
            cell.label.text! = "Start Time"
            return cell
        case (2,1):
            let cell = tableView.dequeueReusableCellWithIdentifier("datePick") as! DatePickCell
            cell.datePicker.datePickerMode = .Time
            return cell
        case (2,2):
            let cell = tableView.dequeueReusableCellWithIdentifier("label") as! LabelCell
            cell.label.text! = "End Time"
            return cell
        case (2,3):
            let cell = tableView.dequeueReusableCellWithIdentifier("datePick") as! DatePickCell
            cell.datePicker.datePickerMode = .Time
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section != 0){
            togglePicker()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func doneSelected(sender: UIBarButtonItem){
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! NameCell
        if let name = cell.stopName.text{
            
            if type == .meal{
                let meal = MealStop(name: name)
                TripModel.shared.stops.append(meal)
            }
            else {
                let gen = GenericStop(name: name)
                TripModel.shared.stops.append(gen)
            }
            
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (!pickerVisible && indexPath.section != 0){
            switch (indexPath.section, indexPath.row) {
            case (1,1):
                 return 0
            case (2,1):
                return 0
            case (2,3):
                return 0
            default:
                break
            }
        }
        
        if (pickerVisible && indexPath.section != 0){
            switch (indexPath.section, indexPath.row) {
            case (1,1):
                return 75
            case (2,1):
                return 75
            case (2,3):
                return 75
            default:
                break
            }
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if  section == 2 {
            if type == .meal {
                 return "TIME FOR MEAL"
            }
            else{
                return "TIME FOR STOP"
            }
        }
        return nil
    }
    
    
    
    //toggle function
    private func togglePicker(){
        pickerVisible = !pickerVisible
        tableView.beginUpdates()
        tableView.endUpdates()
    }

 

}
