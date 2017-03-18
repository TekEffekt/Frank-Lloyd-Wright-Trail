//
//  SignUpVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/22/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import UIKit

class SignUpVC: UITableViewController {
    var cellTapped = false
    var currentRow = -1
    var currentSection = -1
    var dateTag = 0
    var sites = TripModel.shared.getLocations()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        let button = UIBarButtonItem(title: "Confirm", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(doneSelected))
        
        self.navigationItem.title = "Tours"
        self.navigationItem.rightBarButtonItem = button
       

    }
    
    func doneSelected(sender: UIBarButtonItem){
        for i in 0..<TripModel.shared.stops.count{
            if TripModel.shared.stops[i].date == nil {
                TripModel.shared.stops[i].date = NSDate()
            }
            if TripModel.shared.stops[i].startTime == nil {
                TripModel.shared.stops[i].startTime = NSDate()
            }
            if TripModel.shared.stops[i].endTime == nil {
                TripModel.shared.stops[i].endTime = NSDate()
            }
        }
        performSegueWithIdentifier("segueToFinal", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TripModel.shared.getLocationCount()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let sites = TripModel.shared.getLocations(){
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("label", forIndexPath: indexPath) as! LabelCell
                cell.label.textColor = UIColor.blackColor()
                cell.accessoryType = .None
                cell.label.text! = sites[indexPath.section].name
                cell.label.adjustsFontSizeToFitWidth = true
                
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("signup", forIndexPath: indexPath) as! SignUpCell
                
                cell.url.text! = "www.tourtimes.com"
                cell.url.adjustsFontSizeToFitWidth = true
                cell.accessoryType = .DisclosureIndicator
                
                return cell
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("label", forIndexPath: indexPath) as! LabelCell
                
                cell.label.text! = "Tour Date"
                cell.label.textColor = UIColor.lightGrayColor()
                cell.accessoryType = .DisclosureIndicator
                
                return cell
            case 3:
                let cell = tableView.dequeueReusableCellWithIdentifier("datepick", forIndexPath: indexPath) as! DatePickCell
                cell.datePicker.datePickerMode = .Date
                cell.datePicker.tag = indexPath.section
                if let date = sites[indexPath.section].date{
                cell.datePicker.date = date
                }
                return cell
            case 4:
                let cell = tableView.dequeueReusableCellWithIdentifier("label", forIndexPath: indexPath) as! LabelCell
                
                cell.label.text! = "Tour Start"
                cell.label.textColor = UIColor.lightGrayColor()
                cell.accessoryType = .DisclosureIndicator
        
                return cell
            case 5:
                let cell = tableView.dequeueReusableCellWithIdentifier("datepick", forIndexPath: indexPath) as! DatePickCell
                cell.datePicker.datePickerMode = .Time
                cell.datePicker.tag = indexPath.section + 50
                if let time = sites[indexPath.section].startTime{
                    cell.datePicker.date = time
                }
                return cell
            case 6:
                let cell = tableView.dequeueReusableCellWithIdentifier("label", forIndexPath: indexPath) as! LabelCell
                
                cell.label.text! = "Tour End"
                cell.label.textColor = UIColor.lightGrayColor()
                cell.accessoryType = .DisclosureIndicator
                
                return cell
            case 7:
                let cell = tableView.dequeueReusableCellWithIdentifier("datepick", forIndexPath: indexPath) as! DatePickCell
                cell.datePicker.datePickerMode = .Time
                cell.datePicker.tag = indexPath.section
                if let time = sites[indexPath.section].endTime{
                    cell.datePicker.date = time
                }
                return cell
                
            default:
                break
            }
            
        }
      return UITableViewCell()
    }
 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if currentRow != indexPath.row + 1{
            cellTapped = true
            currentRow = indexPath.row + 1
            currentSection = indexPath.section
        }
        
        else{
            cellTapped = false
            currentRow = -1
            currentSection = -1
        }
       
        
        switch indexPath.row {
        case 1:
            print("Go to signup website")
        default:
            break
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
        if indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 7{
        if indexPath.row == currentRow && indexPath.section == currentSection && cellTapped {
            return 75
        }
        
        else if indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 7{
            return 0
        }
        }
        
         return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    @IBAction func dateChanged(picker: UIDatePicker){
        let stops = TripModel.shared.stops
        
        if picker.datePickerMode == .Time && picker.tag > 50{
            let tag = picker.tag - 50
            if let locationName = sites?[tag].name{
                for i in 0..<stops.count{
                    if locationName == stops[i].name{
                        TripModel.shared.stops[i].startTime = picker.date
                        sites = TripModel.shared.getLocations()
                    }
                }
                
            }
        }else if let locationName = sites?[picker.tag].name{
            if picker.datePickerMode == .Date{
                for i in 0..<stops.count{
                    if locationName == stops[i].name{
                        TripModel.shared.stops[i].date = picker.date
                        sites = TripModel.shared.getLocations()
                    }
                }
                
            }else if picker.datePickerMode == .Time{
                for i in 0..<stops.count{
                    if locationName == stops[i].name{
                        TripModel.shared.stops[i].endTime = picker.date
                        sites = TripModel.shared.getLocations()
                    }
                }
                
            }
        }
        
    }

    //toggle function
    private func togglePicker(){
        //pickerVisible = !pickerVisible
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    

}
