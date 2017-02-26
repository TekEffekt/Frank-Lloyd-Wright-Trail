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
  
    var tappedStopType: StopActions?
    var cellTapped = false
    var currentRow = -1
    var currentSection = -1

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Create Trip"
        let button = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(doneSelected))
        
        self.navigationItem.rightBarButtonItem = button
        tableView.reloadData()
    }
    
    func doneSelected(sender: UIBarButtonItem){
        performSegueWithIdentifier("suggestedTL", sender: nil)
        print("Done button pressed")
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
            return TripModel.shared.stops.count + 1
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
            //add stop cell
            if indexPath.row == TripModel.shared.stops.count{
            cell.stopName.text! = "Add Stop"
                return cell
            }
            //stop added cell
            else{
                cell.stopName.text! = TripModel.shared.stops[indexPath.row].name
                cell.stopName.adjustsFontSizeToFitWidth = true
                return cell
            }
        }
            //date pick cell
        else if(indexPath.row == 1 || indexPath.row == 3){
            switch (indexPath.section, indexPath.row) {
            case (1,1):
                let cell = tableView.dequeueReusableCellWithIdentifier("dateCell") as! DatePickCell
                self.dateHelper(cell, indexPath: indexPath)
                cell.datePicker.tag = 11
                return cell
            case (1,3):
                let cell = tableView.dequeueReusableCellWithIdentifier("dateCell") as! DatePickCell
                self.dateHelper(cell, indexPath: indexPath)
                cell.datePicker.tag = 13
                return cell
            case (2,1):
                let cell = tableView.dequeueReusableCellWithIdentifier("dateCell") as! DatePickCell
                self.dateHelper(cell, indexPath: indexPath)
                cell.datePicker.tag = 21
                return cell
            case (2,3):
                let cell = tableView.dequeueReusableCellWithIdentifier("dateCell") as! DatePickCell
                self.dateHelper(cell, indexPath: indexPath)
                cell.datePicker.tag = 23
                return cell
            default:
                break
            }
            
        }
            //label cell
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("labelCell") as! LabelCell
            cell.label.text! = labels[indexPath.section][indexPath.row]
            cell.label.textColor = UIColor.lightGrayColor()
            return cell
        }
        
        return UITableViewCell()
    }
    
    //cell is selected
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0){
            if(indexPath.row == TripModel.shared.stops.count){
                actionSheet()
            }
            else{
                alertPopUp(indexPath)
            }
            
        }
            
        else{
            if currentRow != indexPath.row{
                cellTapped = true
                currentRow = indexPath.row + 1
                currentSection = indexPath.section
            }
            else{
                cellTapped = false
                currentRow = -1
                currentSection = -1
            }
        }
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //change cell height for datepicker when expanded
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if (indexPath.section != 0 && indexPath.row == 1 || indexPath.row == 3){
            if indexPath.row == currentRow && indexPath.section == currentSection && cellTapped{
                return 75
            }
            else if (indexPath.row == 1 || indexPath.row == 3){
                return 0
            }
            
        }
        
        
        
        
        
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        
//        if (!pickerVisible && indexPath.section != 0 && (indexPath.row == 1 || indexPath.row == 3)){
//            return 0
//        }
//        else if (pickerVisible && indexPath.section != 0 && (indexPath.row == 1 || indexPath.row == 3)){
//            return 75
//        }
//        else{
//            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
//        }
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
    
    
    //action sheet button clicked
    private func actionPressed(stopAction:StopActions, indexPath : NSIndexPath?) {
        
        switch stopAction {
        case .location:
            performSegueWithIdentifier("AddLocation", sender: nil)
        case .meal:
            tappedStopType = .meal
            performSegueWithIdentifier("AddStop", sender: nil)
        case .generic:
            tappedStopType = .generic
            performSegueWithIdentifier("AddStop", sender: nil)
        case .cancel:
            dismissViewControllerAnimated(true, completion: nil)
        case .delete:
            let indexPath = indexPath
            TripModel.shared.stops.removeAtIndex(indexPath!.row)
            tableView.reloadData()
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let stopVC =  segue.destinationViewController as? AddStopVC {
            stopVC.type = tappedStopType
        }
    }
    
    
    //create alert popup
    private func alertPopUp(indexPath: NSIndexPath){
        
        let popUpController: UIAlertController = UIAlertController(title: "Delete Stop?", message: "", preferredStyle: .Alert)
        
        let cancelButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel){
            action -> Void in
            self.actionPressed(.cancel, indexPath: indexPath)
        }
        popUpController.addAction(cancelButton)
        
        let deleteButton : UIAlertAction = UIAlertAction(title: "Delete", style: .Default){
            action -> Void in
            self.actionPressed(.delete, indexPath: indexPath)
        }
        popUpController.addAction(deleteButton)
        
        self.presentViewController(popUpController, animated: true, completion: nil)
        
    }
    
    
    
    //create action sheet
    private func actionSheet(){
        let actionSheetController: UIAlertController = UIAlertController(title: "Choose a Type of Stop", message: "", preferredStyle: .ActionSheet)
        
        //Create and add the "Cancel" action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
            self.actionPressed(.cancel, indexPath: nil)
        }
        actionSheetController.addAction(cancelAction)
        
        //Create and add location action
        let locationStop: UIAlertAction = UIAlertAction(title: "Add Location Stop", style: .Default) { action -> Void in
            //The user just pressed the location button.
            self.actionPressed(.location, indexPath: nil)
        }
        actionSheetController.addAction(locationStop)
        
        let mealStop: UIAlertAction = UIAlertAction(title: "Add Meal Stop", style: .Default) { action -> Void in
            //The user just pressed the meal button.
            self.actionPressed(.meal, indexPath: nil)
        }
        actionSheetController.addAction(mealStop)
        
        let genericStop: UIAlertAction = UIAlertAction(title: "Add Generic Stop", style: .Default) { action -> Void in
            //The user just pressed the meal button.
            self.actionPressed(.generic, indexPath: nil)
        }
        actionSheetController.addAction(genericStop)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    //datepicker changed 
    @IBAction func dateChanged(sender: UIDatePicker) {
        switch sender.tag {
        case 11:
            TripModel.shared.startDate = sender.date
            //print("Start date : \(TripModel.shared.startDate)")
        case 13:
            TripModel.shared.startTime = sender.date
            //print("Start time : \(TripModel.shared.startTime)")
        case 21:
            TripModel.shared.endDate = sender.date
            //print("End date : \(TripModel.shared.endDate)")
        case 23:
            TripModel.shared.endTime = sender.date
            //print("End time : \(TripModel.shared.endTime)")
        default:
            break
        }
        
    }
    

}

enum StopActions {
    case location, meal, generic, cancel, delete
}
