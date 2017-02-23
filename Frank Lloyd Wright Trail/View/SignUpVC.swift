//
//  SignUpVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/22/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import UIKit

class SignUpVC: UITableViewController {
    private var pickerVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        let button = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(doneSelected))
        
        self.navigationItem.title = "Signup"
        self.navigationItem.rightBarButtonItem = button
    }
    
    func doneSelected(sender: UIBarButtonItem){
        
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
        switch indexPath.row {
        case 1:
            print("Go to signup website")
        case 2:
            togglePicker()
        case 4:
            togglePicker()
        default:
            break
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(!pickerVisible){
            switch indexPath.row {
            case 3:
                return 0
            case 5:
                return 0
            default:
                break
            }
        }
        
        if(pickerVisible){
            switch indexPath.row {
            case 3:
                return 75
            case 5:
                return 75
            default:
                break
            }
        }
        
         return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    

    //toggle function
    private func togglePicker(){
        pickerVisible = !pickerVisible
        tableView.beginUpdates()
        tableView.endUpdates()
    }

}
