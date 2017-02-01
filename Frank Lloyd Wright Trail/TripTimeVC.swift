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
    @IBOutlet weak var continueButton: UIButton!
    var startHidden = false
    var endHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = NSDate()
        startTimeLabel.text = NSDateFormatter.localizedStringFromDate(date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        endTimeLabel.text = NSDateFormatter.localizedStringFromDate(date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
          //print("---------------------SITES------------------------")
          //print("\(TripModel.shared.getSites())")
    }
    

    @IBAction func startTimeChanged(sender: AnyObject) {
        startTimeLabel.text = NSDateFormatter.localizedStringFromDate(startTimePicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        TripModel.shared.editStartTime(startTimeLabel.text!)
        
        checkTime()
        
        print("Start Time =   \(TripModel.shared.getStartTime())")
    }

    @IBAction func endTimeChanged(sender: AnyObject) {
        endTimeLabel.text = NSDateFormatter.localizedStringFromDate(endTimePicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        TripModel.shared.editEndTime(endTimeLabel.text!)
        checkTime()
        print("End Time =   \(TripModel.shared.getEndTime())")
        print()
    }
    
    func toggle(){
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    private func checkTime() {
        if startTimePicker.date.isLessThanDate(endTimePicker.date) {
            continueButton.userInteractionEnabled = true
            //continueButton.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            continueButton.backgroundColor = UIColor.orangeColor()
        } else {
            continueButton.userInteractionEnabled = false
            continueButton.backgroundColor = UIColor.lightGrayColor()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        
        if row == 0 && indexPath.section == 0 {
            startHidden = !startHidden
            toggle()
        }
        else if row == 2 && indexPath.section == 0 {
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
