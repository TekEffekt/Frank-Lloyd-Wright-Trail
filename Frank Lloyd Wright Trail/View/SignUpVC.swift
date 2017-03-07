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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        let button = UIBarButtonItem(title: "Confirm", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(doneSelected))
        
        self.navigationItem.title = "Signup"
        self.navigationItem.rightBarButtonItem = button
    }
    
    func doneSelected(sender: UIBarButtonItem){
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
        return 6
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let sites = TripModel.shared.getLocations(){
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("label", forIndexPath: indexPath) as! LabelCell
                
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
                
                cell.label.text! = "Date"
                cell.label.textColor = UIColor.lightGrayColor()
                cell.accessoryType = .DisclosureIndicator
                
                return cell
            case 3:
                let cell = tableView.dequeueReusableCellWithIdentifier("datepick", forIndexPath: indexPath) as! DatePickCell
                cell.datePicker.datePickerMode = .Date
                
                return cell
            case 4:
                let cell = tableView.dequeueReusableCellWithIdentifier("label", forIndexPath: indexPath) as! LabelCell
                
                cell.label.text! = "Time"
                cell.label.textColor = UIColor.lightGrayColor()
                cell.accessoryType = .DisclosureIndicator
        
                return cell
            case 5:
                let cell = tableView.dequeueReusableCellWithIdentifier("datepick", forIndexPath: indexPath) as! DatePickCell
                cell.datePicker.datePickerMode = .Time
                return cell
                
            default:
                break
            }
            
        }
         return UITableViewCell()
    }
 
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
    
        if (indexPath.row == 3 || indexPath.row == 5){
        if indexPath.row == currentRow && indexPath.section == currentSection && cellTapped {
            return 75
        }
        
        else if (indexPath.row == 3 || indexPath.row == 5){
            return 0
        }
        }
        
         return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    

    //toggle function
    private func togglePicker(){
        //pickerVisible = !pickerVisible
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    

}
