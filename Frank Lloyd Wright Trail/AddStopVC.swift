//
//  AddStopVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/19/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import UIKit

class AddStopVC: FormViewController{
    var cellTapped = false
    var currentRow = -1
    var currentSection = -1
    var type: StopActions?
    var genStop: GenericStop?
    var mealStop: MealStop?
    var stop: Stop?
    var trip: Trip!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genStop = GenericStop(name : "")
        mealStop = MealStop(name: "")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Add Stop"
        
        let button = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneSelected))
        
        self.navigationItem.rightBarButtonItem = button
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 4
        default:
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "name") as! NameCell
            cell.stopName.placeholder = "Stop Name"
            return cell
        case (1,0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "label") as! LabelCell
            cell.label.text! = "Date"
            return cell
        case (1,1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "datePick") as! DatePickCell
            cell.datePicker.datePickerMode = .date
            cell.datePicker.tag = 11
            return cell
        case (2,0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "label") as! LabelCell
            cell.label.text! = "Start Time"
            return cell
        case (2,1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "datePick") as! DatePickCell
            cell.datePicker.datePickerMode = .time
            cell.datePicker.tag = 21
            return cell
        case (2,2):
            let cell = tableView.dequeueReusableCell(withIdentifier: "label") as! LabelCell
            cell.label.text! = "End Time"
            return cell
        case (2,3):
            let cell = tableView.dequeueReusableCell(withIdentifier: "datePick") as! DatePickCell
            cell.datePicker.datePickerMode = .time
            cell.datePicker.tag = 23
            return cell
        default:
            return UITableViewCell()
        }
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
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func doneSelected(_ sender: UIBarButtonItem){
        var indexPath = IndexPath(row: 0, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath) as! NameCell
        
        indexPath = IndexPath(row: 1, section: 1)
        let dateCell = tableView.cellForRow(at: indexPath) as! DatePickCell
        indexPath = IndexPath(row: 1, section: 2)
        let startTimeCell = tableView.cellForRow(at: indexPath) as! DatePickCell
        indexPath = IndexPath(row: 3, section: 2)
        let endTimeCell = tableView.cellForRow(at: indexPath) as! DatePickCell
        
        if type == .meal{
            mealStop?.date = dateCell.datePicker.date
            mealStop?.startTime = startTimeCell.datePicker.date
            mealStop?.endTime = endTimeCell.datePicker.date
        }else{
            genStop?.date = dateCell.datePicker.date
            genStop?.startTime = dateCell.datePicker.date
            genStop?.endTime = endTimeCell.datePicker.date
        }
        
        if let name = cell.stopName.text, !name.isEmpty{
            
            if type == .meal{
                mealStop?.name = name
                RealmWrite.add(mealStop: mealStop!, trip: self.trip)
                stop = mealStop
            }
            else {
                genStop?.name = name
                RealmWrite.add(genericStop: genStop!, trip: self.trip)
                stop = genStop
            }
            
        }else{
            print("no stop name")
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 0 && (indexPath.row == 1 || indexPath.row == 3) {
            if indexPath.row == currentRow && indexPath.section == currentSection && cellTapped{
                return 75
            }
            
            else{
                return 0
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if  section == 2 {
            if type == .meal {
                 return "TIME FOR MEAL"
            }
            else{
                return "TIME FOR STOP"
            }
        }
        return nil
    }

}
