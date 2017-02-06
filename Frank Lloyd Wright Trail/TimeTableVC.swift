//
//  TimeTableVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 10/25/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class TimeTableVC: UITableViewController {
    
    // Breakfast outlets
    // --------------------------------------------
    
    @IBOutlet weak var breakfastSwitch: UISwitch!
    @IBOutlet weak var breakfastStartTime: UILabel!
    @IBOutlet weak var breakfastStartPicker: UIDatePicker!
    @IBOutlet weak var breakfastEndTime: UILabel!
    @IBOutlet weak var breakfastEndPicker: UIDatePicker!
    
    // Lunch Outlets
    // --------------------------------------------

    @IBOutlet weak var lunchSwitch: UISwitch!
    @IBOutlet weak var lunchStartTime: UILabel!
    @IBOutlet weak var lunchStartPicker: UIDatePicker!
    @IBOutlet weak var lunchEndTime: UILabel!
    @IBOutlet weak var lunchEndPicker: UIDatePicker!
    
    // Dinner outlets
    // ---------------------------------------------
    @IBOutlet weak var dinnerSwitch: UISwitch!
    @IBOutlet weak var dinnerStartTime: UILabel!
    @IBOutlet weak var dinnerStartPicker: UIDatePicker!
    @IBOutlet weak var dinnerEndTime: UILabel!
    @IBOutlet weak var dinnerEndPicker: UIDatePicker!
    
    //continue button
    @IBOutlet weak var continueButton: UIButton!
    
    
    var lunch = false

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    var breakfast = false
    
    /// Toggle function for breakfast to say whehter or not breakast has been
    /// switched on.
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func breakfastChanged(sender: AnyObject) {
        breakfast = !breakfast
        toggle()
    }
    
    /// Toggle function for lunch to say whether or not lunch is going to be
    /// accounted for
    ///
    /// - Parameter sender: switch changed value
    @IBAction func lunchChanged(sender: AnyObject) {
        lunch = !lunch
        toggle()
    }
    
    var dinner = false
    @IBAction func dinnerChanged(sender: AnyObject) {
        dinner = !dinner
        toggle()
    }
    
    func toggle(){
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    
    private func checkTime(start : UIDatePicker, end : UIDatePicker) {
        //check times for single start/end time within one section (breakfast,lunch or dinner)
        if start.date.isLessThanDate(end.date) {
            continueButton.userInteractionEnabled = true
            //continueButton.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            continueButton.backgroundColor = UIColor.orangeColor()
        } else {
            continueButton.userInteractionEnabled = false
            continueButton.backgroundColor = UIColor.lightGrayColor()
        }
        //check that start time is within start time of overall trip time
        
        
        //check that end time is within end time of overall trip time
        
        //check breakfast/lunch/dinner times logic relative to eachother
    }
    
    /// These methods update the text field if the date picker has been changed
    ///
    /// - Parameter sender: date picker changed
    /// -----------------------------------------------------------------------
    @IBAction func breakfastStartValue(sender: AnyObject) {
        breakfastStartTime.text = NSDateFormatter.localizedStringFromDate(breakfastStartPicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        checkTime(breakfastStartPicker, end: breakfastEndPicker)
        TripModel.shared.editBreakfastStartTime(breakfastStartTime.text!)
    }
    
    @IBAction func breakfastEndValue(sender: AnyObject) {
        breakfastEndTime.text = NSDateFormatter.localizedStringFromDate(breakfastEndPicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        checkTime(breakfastStartPicker, end: breakfastEndPicker)
        TripModel.shared.editBreakfastEndTime(breakfastEndTime.text!)
    }
    
    
    @IBAction func lunchStartValue(sender: AnyObject) {
        lunchStartTime.text = NSDateFormatter.localizedStringFromDate(lunchStartPicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        checkTime(lunchStartPicker, end: lunchEndPicker)
        TripModel.shared.editLunchStartTime(lunchStartTime.text!)
    }
    
    
    @IBAction func lunchEndValue(sender: AnyObject) {
        lunchEndTime.text = NSDateFormatter.localizedStringFromDate(lunchEndPicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        checkTime(lunchStartPicker, end: lunchEndPicker)
        TripModel.shared.editLunchEndTime(lunchEndTime.text!)
    }

    @IBAction func dinnerStartValue(sender: AnyObject) {
        dinnerStartTime.text = NSDateFormatter.localizedStringFromDate(dinnerStartPicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        checkTime(dinnerStartPicker, end: dinnerEndPicker)
        TripModel.shared.editDinnerStartTime(dinnerStartTime.text!)
    }
    
    @IBAction func dinnerEndValue(sender: AnyObject) {
        dinnerEndTime.text = NSDateFormatter.localizedStringFromDate(dinnerEndPicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
         checkTime(dinnerStartPicker, end: dinnerEndPicker)
        TripModel.shared.editDinnerEndTime(dinnerEndTime.text!)
    }
    /// -----------------------------------------------------------------------
    

    
    /// Booleans to set whether or not the date pickers for each section are hidden or shown
    var breakfastStartHidden = true
    var breakfastEndHidden = true
    
    var lunchStartHidden = true
    var lunchEndHidden = true
    
    var dinnerStartHidden = true
    var dinnerEndHidden = true
    
    
    /// When a cell is tapped it will expand the the datepickers for each section. 
    ///
    ///
    /// - Parameters:
    ///   - tableView: table that is show on the screen
    ///   - indexPath: current row and section
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentSection = indexPath.section
        let currentRow = indexPath.row
        switch currentSection{
        case 0:
            if currentRow%2 == 1 {
                breakfastStartHidden = !breakfastStartHidden
                toggle()
            }
            else if currentRow == 3{
                breakfastEndHidden = !breakfastEndHidden
                toggle()
            }
        case 1:
            if currentRow == 1 {
                lunchStartHidden = !lunchStartHidden
                toggle()
            }
            else if currentRow == 3{
                lunchEndHidden = !lunchEndHidden
                toggle()
            }
        case 2:
            if currentRow == 1 {
                dinnerStartHidden = !dinnerStartHidden
                toggle()
            }
            else if currentRow == 3{
                dinnerEndHidden = !dinnerEndHidden
                toggle()
            }
        default:
            break
            
        }
        
    }
    

    
    /// This method determine the size of a given cell based on whether switches are turned on and if a cell 
    /// is tapped or not.
    ///
    /// - Parameters:
    ///   - tableView: The table view that will display all of the options for time
    ///   - indexPath: Used to determine current row and current section
    /// - Returns: The size of the cell
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            if breakfast && row%2 == 1 || row == 0{
                return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
            }
            else if !breakfastStartHidden || !breakfastEndHidden && row%2 == 0 {
                return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
            }
        }
        else if section == 1{
            if lunch && row%2 == 1 || row == 0 {
                return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
            }
            else if !lunchStartHidden || !lunchEndHidden && row%2 == 0 {
                return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
            }

        }
        else if section == 2 {
            if dinner && row%2 == 1 || row == 0{
                return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
            }
            else if !dinnerStartHidden || !dinnerStartHidden && row%2 == 0 {
                return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
            }

        }
        
        else if section == 3 {
            return 43
            
        }
        
        
        return 0
    }


}
