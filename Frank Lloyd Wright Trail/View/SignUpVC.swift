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
    
    override func viewWillAppear(_ animated: Bool) {
        let button = UIBarButtonItem(title: "Confirm", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneSelected))
        
        self.navigationItem.title = "Tours"
        self.navigationItem.rightBarButtonItem = button
       

    }
    
    func doneSelected(_ sender: UIBarButtonItem){
        for i in 0..<TripModel.shared.stops.count{
            if TripModel.shared.stops[i].date == nil {
                TripModel.shared.stops[i].date = Date()
            }
            if TripModel.shared.stops[i].startTime == nil {
                TripModel.shared.stops[i].startTime = Date()
            }
            if TripModel.shared.stops[i].endTime == nil {
                TripModel.shared.stops[i].endTime = Date()
            }
        }
        performSegue(withIdentifier: "segueToFinal", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return TripModel.shared.getLocationCount()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let sites = TripModel.shared.getLocations(){
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "label", for: indexPath) as! LabelCell
                cell.label.textColor = UIColor.black
                cell.accessoryType = .none
                cell.label.text! = sites[indexPath.section].name
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
                cell.datePicker.tag = indexPath.section + 50
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
        let stops = TripModel.shared.stops
        
        if picker.datePickerMode == .time && picker.tag > 50{
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
            if picker.datePickerMode == .date{
                for i in 0..<stops.count{
                    if locationName == stops[i].name{
                        TripModel.shared.stops[i].date = picker.date
                        sites = TripModel.shared.getLocations()
                    }
                }
                
            }else if picker.datePickerMode == .time{
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
    fileprivate func togglePicker(){
        //pickerVisible = !pickerVisible
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    

}
