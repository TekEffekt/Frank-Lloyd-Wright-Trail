//
//  CreateTripVC.swift
//  Frank Lloyd Wright Trail
//  This view controller is used to control the view which asks the user to add any stops if necessary and to also to select their start dates and end dates, taking in mind which trip type they selected
//  Created by Max on 2/14/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation

class CreateTripVC : UITableViewController {
    
    let section = ["STOPS", "TRIP START", "TRIP END"]
    var labels = [["Add Stop"], ["Start Date", " ", "Start Time"], ["End Date", " ", "End Time"]]
    private var pickerVisible = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Create Trip"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.section.count
    }
    
    //number of rows in each section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return labels[0].count
        }
        else {
            return 4
        }
    }
    
    //set header titles
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    //configure cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //add stop cell
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! AddStopCell
            cell.stopName.text! = labels[0][indexPath.row]
            return cell
        }
            //date picker cell
        else if(indexPath.row == 1 || indexPath.row == 3){
            let cell = tableView.dequeueReusableCellWithIdentifier("dateCell") as! DatePickCell
            self.dateHelper(cell, indexPath: indexPath)
            return cell
        }
            //label cell
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("labelCell") as! LabelCell
            cell.label.text! = labels[indexPath.section][indexPath.row]
            cell.label.textColor = UIColor.lightGrayColor()
            return cell
        }
    }
    
    //cell is selected
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0){
            
        }
        else{
            togglePicker()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //change cell height for datepicker when expanded
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (!pickerVisible && indexPath.section != 0 && (indexPath.row == 1 || indexPath.row == 3)){
            return 0
        }
        else{
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    

    
    //to help format the datepicker
    func dateHelper(cell: DatePickCell, indexPath: NSIndexPath){
        if (indexPath.row == 1){
            cell.datePicker.datePickerMode = UIDatePickerMode.Date
        }
        else {
            cell.datePicker.datePickerMode = UIDatePickerMode.Time
        }
        
        //check trip type to decide where to start date at
        //also check if it is a start date or end date
        //        switch TripModel.shared.type! {
        //        case "weekend":
        //            break
        //
        //                //NSCalendar.currentCalendar().nextDateAfterDate(cell.datePick.date, matchingUnit: .Day, value: 6, options: [])!
        //
        //            //cell.datePick.date = date.nextDateAfterDate(cell.datePick.date, matchingUnit: .Day, value: 06, options: [])!
        //
        //        case "winter":
        //            cell.datePick.date = NSCalendar.currentCalendar().nextDateAfterDate(cell.datePick.date, matchingUnit: .Month, value: 12, options: [])!
        //            cell.datePick.date = NSCalendar.currentCalendar().nextDateAfterDate(cell.datePick.date, matchingUnit: .Day, value: 20, options: [])!
        //
        //        case "tomorrow":
        //            let tomorrow = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 1, toDate: cell.datePick.date, options: [])
        //            cell.datePick.date = tomorrow!
        //        default:
        //            break
        //        }
        
        
    }
    
    //toggle function
    private func togglePicker(){
        pickerVisible = !pickerVisible
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    
    
    
    
    
    
}
