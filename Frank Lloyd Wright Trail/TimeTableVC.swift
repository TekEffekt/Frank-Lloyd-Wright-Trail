//
//  TimeTableVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 10/25/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class TimeTableVC: UITableViewController {

    @IBOutlet weak var lunchToggle: UISwitch!
    @IBOutlet weak var lunchStartTime: UILabel!
    @IBOutlet weak var lunchStart: UIDatePicker!
    @IBOutlet weak var lunchEndTime: UILabel!
    @IBOutlet weak var lunchEnd: UIDatePicker!
    
    @IBOutlet weak var dinnerToggle: UISwitch!
    @IBOutlet weak var dinnerStartTime: UILabel!
    @IBOutlet weak var dinnerStart: UIDatePicker!
    
    
    
    var isLunch = true
    var lunchStartHidden = true
    var lunchEndHidden = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerChanged()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func lunchChanged(sender: AnyObject) {
        isLunch = !isLunch
        toggleLunch()
        
    }
    func toggleLunch(){
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    
    @IBAction func lunchStartValue(sender: AnyObject) {
        datePickerChanged()
    }
    
    func datePickerChanged () {
        lunchStartTime.text = NSDateFormatter.localizedStringFromDate(lunchStart.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        lunchEndTime.text = NSDateFormatter.localizedStringFromDate(lunchEnd.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)

    }

    @IBAction func lunchEndValue(sender: AnyObject) {
        datePickerChanged()
    }
    




    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 1 {
            lunchStartHidden = !lunchStartHidden
            toggleLunch()
        }
        else if indexPath.section == 0 && indexPath.row == 3{
            lunchEndHidden = !lunchEndHidden
            toggleLunch()
        }
        
        
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        print("Bool: \(lunchToggle.on)")
        if isLunch && indexPath.section == 0 && indexPath.row%2 == 1 || indexPath.row == 0 {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
        else if !isLunch && indexPath.section == 0 && indexPath.row > 0{
            return 0
        }
        else if !lunchStartHidden && indexPath.section == 0 && indexPath.row == 2 {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
        else if !lunchEndHidden && indexPath.section == 0 && indexPath.row == 4 {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
        else {
            return 0
        }
    

    }


}
