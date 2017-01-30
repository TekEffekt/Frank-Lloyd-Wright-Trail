//
//  TripTimeVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 11/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class TripTimeVC: UITableViewController {
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    
    var trip: TripModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = NSDate()
        startTimeLabel.text = NSDateFormatter.localizedStringFromDate(date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        endTimeLabel.text = NSDateFormatter.localizedStringFromDate(date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        
          print("\(trip!.getSites())")
    }
    

    @IBAction func startTimeChanged(sender: AnyObject) {
        startTimeLabel.text = NSDateFormatter.localizedStringFromDate(startTimePicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }

    @IBAction func endTimeChanged(sender: AnyObject) {
        endTimeLabel.text = NSDateFormatter.localizedStringFromDate(endTimePicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }
    func toggle(){
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    var startHidden = false
    var endHidden = false
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        
        if row == 0 {
            startHidden = !startHidden
            toggle()
        }
        else if row == 2{
            endHidden = !endHidden
            toggle()
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let row = indexPath.row
        if row == 0 || row == 2{
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
        else if startHidden && row == 1{
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)

        }
        else if endHidden && row == 3{
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
        else{
            return 0
        }
        


    }
    
    
}
