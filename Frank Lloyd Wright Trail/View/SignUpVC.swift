//
//  SignUpVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/22/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import UIKit
import RealmSwift

class SignUpVC: UITableViewController {
    var cellTapped = false
    var currentRow = -1
    var currentSection = -1
    var dateTag = 0
    var sites = List<SiteStop>()
    var trip: Trip!
    var wayPointOrder = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sites = trip.siteStops
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let button = UIBarButtonItem(title: "Confirm", style: UIBarButtonItemStyle.plain, target: self, action: #selector(confirmSelected))
        
        self.navigationItem.title = "Tours"
        self.navigationItem.rightBarButtonItem = button
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let finalTL = segue.destination as! FinalTimeLineVC
        finalTL.trip = self.trip
    }
    
    func confirmSelected(_ sender: UIBarButtonItem){
        for i in 0..<trip.siteStops.count{
            let index = wayPointOrder[i]
            let site = trip.siteStops[index]
            if site.date == nil {
                RealmWrite.writeSiteStopDate(index: index, date: Date(), trip: self.trip)
            }
            if site.startTime == nil {
                RealmWrite.writeSiteStopStartTime(index: index, date: Date(), trip: self.trip)
            }
            if site.endTime == nil {
                RealmWrite.writeSiteStopEndTime(index: index, date: Date(), trip: self.trip)
            }
            
            let fullStartDate = CombineDates.combineDateWithTime(trip.siteStops[index].date!, time: trip.siteStops[index].startTime!)
            RealmWrite.writeSiteStopFullStartDate(index: index, date: fullStartDate!, trip: self.trip)
            
            let fullEndDate = CombineDates.combineDateWithTime(trip.siteStops[index].date!, time: trip.siteStops[index].endTime!)
            RealmWrite.writeSiteStopFullEndDate(index: index, date: fullEndDate!, trip: self.trip)
        }
        
        
        performSegue(withIdentifier: "segueToFinal", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return trip.siteStops.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = wayPointOrder[indexPath.section]
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "signup", for: indexPath) as! SignUpCell
            
            cell.url.text! = "www.tourtimes.com"
            cell.url.adjustsFontSizeToFitWidth = true
            cell.accessoryType = .disclosureIndicator
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "label", for: indexPath) as! LabelCell
            
            cell.label.text! = "Tour Date"
            cell.label.textColor = UIColor.lightGray
            cell.accessoryType = .disclosureIndicator
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "datepick", for: indexPath) as! DatePickCell
            cell.datePicker.datePickerMode = .date
            cell.datePicker.tag = index
            if let date = sites[index].date {
                cell.datePicker.date = date as Date
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "label", for: indexPath) as! LabelCell
            
            cell.label.text! = "Tour Start"
            cell.label.textColor = UIColor.lightGray
            cell.accessoryType = .disclosureIndicator
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "datepick", for: indexPath) as! DatePickCell
            cell.datePicker.datePickerMode = .time
            cell.datePicker.tag = index + 30
            if let time = sites[index].startTime {
                cell.datePicker.date = time as Date
            }
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "label", for: indexPath) as! LabelCell
            
            cell.label.text! = "Tour End"
            cell.label.textColor = UIColor.lightGray
            cell.accessoryType = .disclosureIndicator
            
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "datepick", for: indexPath) as! DatePickCell
            cell.datePicker.datePickerMode = .time
            cell.datePicker.tag = index
            if let time = sites[index].endTime {
                cell.datePicker.date = time as Date
            }
            return cell
            
        default:
            break
        }
        return UITableViewCell()
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sites[wayPointOrder[section]].name!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if currentRow != indexPath.row + 1 {
            cellTapped = true
            currentRow = indexPath.row + 1
            currentSection = indexPath.section
        }
            
        else {
            cellTapped = false
            currentRow = -1
            currentSection = -1
        }
        
        
        switch indexPath.row {
        case 0:
            print("Go to signup website")
        default:
            break
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 6 {
            if indexPath.row == currentRow && indexPath.section == currentSection && cellTapped {
                return 75
            }
                
            else if indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 6 {
                return 0
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    @IBAction func dateChanged(_ picker: UIDatePicker){
        //must set full start/ full end time
        if picker.datePickerMode == .time && picker.tag >= 30 {
            let tag = picker.tag - 30
            if let locationName = sites[wayPointOrder[tag]].name {
                for i in 0..<sites.count{
                    if locationName == sites[i].name {
                        RealmWrite.writeSiteStopStartTime(index: i, date: picker.date, trip: self.trip)
                        if sites[i].date == nil {
                            RealmWrite.writeSiteStopDate(index: i, date: Date(), trip: self.trip)
                        } else {
                            let fullStartDate = CombineDates.combineDateWithTime(trip.siteStops[i].date!, time: trip.siteStops[i].startTime!)
                            RealmWrite.writeSiteStopFullStartDate(index: i, date: fullStartDate!, trip: self.trip)
                        }
                    }
                }
            }
        } else if let locationName = sites[picker.tag].name {
            if picker.datePickerMode == .date {
                for i in 0..<sites.count{
                    if locationName == sites[i].name {
                        RealmWrite.writeSiteStopDate(index: i, date: picker.date, trip: self.trip)
                        if sites[i].startTime == nil {
                            RealmWrite.writeSiteStopStartTime(index: i, date: Date(), trip: self.trip)
                        } else {
                            let fullStartDate = CombineDates.combineDateWithTime(trip.siteStops[i].date!, time: trip.siteStops[i].startTime!)
                            RealmWrite.writeSiteStopFullStartDate(index: i, date: fullStartDate!, trip: self.trip)
                        }
                        
                        if sites[i].endTime == nil {
                            RealmWrite.writeSiteStopEndTime(index: i, date: Date(), trip: self.trip)
                        } else {
                            let fullEndDate = CombineDates.combineDateWithTime(trip.siteStops[i].date!, time: trip.siteStops[i].endTime!)
                            RealmWrite.writeSiteStopFullEndDate(index: i, date: fullEndDate!, trip: self.trip)
                        }
                    }
                }
                
            } else if picker.datePickerMode == .time {
                for i in 0..<sites.count{
                    if locationName == sites[i].name{
                        RealmWrite.writeSiteStopEndTime(index: i, date: picker.date, trip: self.trip)
                    } else {
                        continue
                    }
                    if sites[i].date == nil {
                        RealmWrite.writeSiteStopDate(index: i, date: Date(), trip: self.trip)
                    } else {
                        let fullEndDate = CombineDates.combineDateWithTime(trip.siteStops[i].date!, time: trip.siteStops[i].endTime!)
                        RealmWrite.writeSiteStopFullEndDate(index: i, date: fullEndDate!, trip: self.trip)
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
