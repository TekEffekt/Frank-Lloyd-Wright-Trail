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
    var trip = Trip()
    
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
            if trip.siteStops[i].date == nil {
                trip.siteStops[i].date = Date()
            }
            if trip.siteStops[i].startTime == nil {
                trip.siteStops[i].startTime = Date()
            }
            if trip.siteStops[i].endTime == nil {
                trip.siteStops[i].endTime = Date()
            }
        }
        
//        for site in trip.siteStops{
//            RealmWrite.add(siteStop: site, trip: self.trip)
//        }
        
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
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "label", for: indexPath) as! LabelCell
                cell.label.textColor = UIColor.black
                cell.accessoryType = .none
                cell.label.text! = sites[indexPath.section].name!
                cell.label.adjustsFontSizeToFitWidth = true
                
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "signup", for: indexPath) as! SignUpCell
                
                cell.url.text! = "www.tourtimes.com"
                cell.url.adjustsFontSizeToFitWidth = true
                cell.accessoryType = .disclosureIndicator
                
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "label", for: indexPath) as! LabelCell
                
                cell.label.text! = "Tour Date"
                cell.label.textColor = UIColor.lightGray
                cell.accessoryType = .disclosureIndicator
                
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "datepick", for: indexPath) as! DatePickCell
                cell.datePicker.datePickerMode = .date
                cell.datePicker.tag = indexPath.section
                if let date = sites[indexPath.section].date{
                    cell.datePicker.date = date as Date
                }
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "label", for: indexPath) as! LabelCell
                
                cell.label.text! = "Tour Start"
                cell.label.textColor = UIColor.lightGray
                cell.accessoryType = .disclosureIndicator
                
                return cell
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "datepick", for: indexPath) as! DatePickCell
                cell.datePicker.datePickerMode = .time
                cell.datePicker.tag = indexPath.section + 30
                if let time = sites[indexPath.section].startTime{
                    cell.datePicker.date = time as Date
                }
                return cell
            case 6:
                let cell = tableView.dequeueReusableCell(withIdentifier: "label", for: indexPath) as! LabelCell
                
                cell.label.text! = "Tour End"
                cell.label.textColor = UIColor.lightGray
                cell.accessoryType = .disclosureIndicator
                
                return cell
            case 7:
                let cell = tableView.dequeueReusableCell(withIdentifier: "datepick", for: indexPath) as! DatePickCell
                cell.datePicker.datePickerMode = .time
                cell.datePicker.tag = indexPath.section
                if let time = sites[indexPath.section].endTime{
                    cell.datePicker.date = time as Date
                }
                return cell
                
            default:
                break
            }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 7{
            if indexPath.row == currentRow && indexPath.section == currentSection && cellTapped {
                return 75
            }
                
            else if indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 7{
                return 0
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    @IBAction func dateChanged(_ picker: UIDatePicker){
        
        if picker.datePickerMode == .time && picker.tag >= 30{
            let tag = picker.tag - 30
            if let locationName = sites[tag].name{
                for i in 0..<sites.count{
                    if locationName == sites[i].name{
                        trip.siteStops[i].startTime = picker.date
                    }
                }
                
            }
        }else if let locationName = sites[picker.tag].name{
            if picker.datePickerMode == .date{
                for i in 0..<sites.count{
                    if locationName == sites[i].name{
                        trip.siteStops[i].date = picker.date
                    }
                }
                
            }else if picker.datePickerMode == .time{
                for i in 0..<sites.count{
                    if locationName == sites[i].name{
                        trip.siteStops[i].endTime = picker.date
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
