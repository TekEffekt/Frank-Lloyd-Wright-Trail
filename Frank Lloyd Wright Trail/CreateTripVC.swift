//
//  CreateTripVC.swift
//  Frank Lloyd Wright Trail
//  This view controller is used to control the view which asks the user to add any stops if necessary and to also to select their start dates and end dates, taking in mind which trip type they selected
//  Created by Max on 2/14/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation

class CreateTripVC : FormViewController {
    
    let section = ["TRIP", "STOPS", "TRIP START", "TRIP END"]
    var labels = [["TRIP"], ["Add Stop"], ["Start Date", " ", "Start Time"], ["End Date", " ", "End Time"]]
  
    var tappedStopType: StopActions?
    var cellTapped = false
    var currentRow = -1
    var currentSection = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Create Trip"
        let button = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(nextSelected))
        
        self.navigationItem.rightBarButtonItem = button
        tableView.reloadData()
    }
    
    func nextSelected(_ sender: UIBarButtonItem){
        validate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count
    }
    
    //number of rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1 {
            return TripModel.shared.stops.count + 1
        }else {
            return 4
        }
    }
    
    
    //set header titles
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return nil
        }
        
        return self.section[section]
    }
    
    //configure cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //name cell
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell") as! NameCell
            cell.stopName.font = UIFont.systemFont(ofSize: 17)
            cell.stopName.placeholder = "Trip Name"
            return cell
        }
        //add stop cell
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AddStopCell
            //add stop cell
            if indexPath.row == TripModel.shared.stops.count{
                cell.stopName.text! = "Add Stop"
                cell.modifyImage.image = UIImage(named: "Add")
                cell.stopName.textColor = UIColor(hexString: "#0073FF")
                return cell
            }
            //stop added cell
            else{
                cell.stopName.text! = TripModel.shared.stops[indexPath.row].name
                cell.stopName.adjustsFontSizeToFitWidth = true
                cell.modifyImage.image = UIImage(named: "Minus")
                cell.stopName.textColor = UIColor.black
                return cell
            }
        }
            //date pick cell
        else if(indexPath.row == 1 || indexPath.row == 3){
            switch (indexPath.section, indexPath.row) {
            case (2,1):
                let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell") as! DatePickCell
                self.dateHelper(cell, indexPath: indexPath)
                cell.datePicker.tag = 21
                if let date = TripModel.shared.startDate{
                    cell.datePicker.date = date as Date
                }
                return cell
            case (2,3):
                let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell") as! DatePickCell
                self.dateHelper(cell, indexPath: indexPath)
                cell.datePicker.tag = 23
                if let time = TripModel.shared.startTime{
                    cell.datePicker.date = time as Date
                }
                return cell
            case (3,1):
                let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell") as! DatePickCell
                self.dateHelper(cell, indexPath: indexPath)
                cell.datePicker.tag = 31
                if let date = TripModel.shared.endDate{
                    cell.datePicker.date = date as Date
                }
                return cell
            case (3,3):
                let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell") as! DatePickCell
                self.dateHelper(cell, indexPath: indexPath)
                cell.datePicker.tag = 33
                if let time = TripModel.shared.endTime{
                    cell.datePicker.date = time as Date
                }
                return cell
            default:
                break
            }
            
        }
            //label cell
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell") as! LabelCell
            cell.label.text! = labels[indexPath.section][indexPath.row]
            cell.label.textColor = UIColor.lightGray
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    //cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1{
            if(indexPath.row == TripModel.shared.stops.count){
                actionSheet()
            }
            else{
                alertPopUp(indexPath)
            }
            
        }
            
        else if indexPath.section == 2 || indexPath.section == 3{
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
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //change cell height for datepicker when expanded
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.section != 0 && indexPath.section != 1 && indexPath.row == 1 || indexPath.row == 3){
            
            if indexPath.row == currentRow && indexPath.section == currentSection && cellTapped{
                return 75
            }
            else if (indexPath.row == 1 || indexPath.row == 3 && indexPath.section != 1 && indexPath.section != 0){
                return 0
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    

    
    //to help format the datepicker
    func dateHelper(_ cell: DatePickCell, indexPath: IndexPath){
        if (indexPath.row == 1){
            cell.datePicker.datePickerMode = UIDatePickerMode.date
        }
        else {
            cell.datePicker.datePickerMode = UIDatePickerMode.time
        }
    }
    
    
    //action sheet button clicked
    fileprivate func actionPressed(_ stopAction:StopActions, indexPath : IndexPath?) {
        
        switch stopAction {
        case .location:
            performSegue(withIdentifier: "AddLocation", sender: nil)
        case .meal:
            tappedStopType = .meal
            performSegue(withIdentifier: "AddStop", sender: nil)
        case .generic:
            tappedStopType = .generic
            performSegue(withIdentifier: "AddStop", sender: nil)
        case .cancel:
            dismiss(animated: true, completion: nil)
        case .delete:
            let indexPath = indexPath
            TripModel.shared.stops.remove(at: indexPath!.row)
            tableView.reloadData()
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let stopVC =  segue.destination as? AddStopVC {
            stopVC.type = tappedStopType
        }
    }
    
    
    //create alert popup
    fileprivate func alertPopUp(_ indexPath: IndexPath){
        
        let popUpController: UIAlertController = UIAlertController(title: "Delete Stop?", message: "", preferredStyle: .alert)
        
        let cancelButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel){
            action -> Void in
            self.actionPressed(.cancel, indexPath: indexPath)
        }
        popUpController.addAction(cancelButton)
        
        let deleteButton : UIAlertAction = UIAlertAction(title: "Delete", style: .default){
            action -> Void in
            self.actionPressed(.delete, indexPath: indexPath)
        }
        popUpController.addAction(deleteButton)
        
        self.present(popUpController, animated: true, completion: nil)
        
    }
    
    
    
    //create action sheet
    fileprivate func actionSheet(){
        let actionSheetController: UIAlertController = UIAlertController(title: "Choose a Type of Stop", message: "", preferredStyle: .actionSheet)
        
        //Create and add the "Cancel" action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
            self.actionPressed(.cancel, indexPath: nil)
        }
        actionSheetController.addAction(cancelAction)
        
        //Create and add location action
        let locationStop: UIAlertAction = UIAlertAction(title: "Add Location Stop", style: .default) { action -> Void in
            //The user just pressed the location button.
            self.actionPressed(.location, indexPath: nil)
        }
        actionSheetController.addAction(locationStop)
        
        let mealStop: UIAlertAction = UIAlertAction(title: "Add Meal Stop", style: .default) { action -> Void in
            //The user just pressed the meal button.
            self.actionPressed(.meal, indexPath: nil)
        }
        actionSheetController.addAction(mealStop)
        
        let genericStop: UIAlertAction = UIAlertAction(title: "Add Generic Stop", style: .default) { action -> Void in
            //The user just pressed the meal button.
            self.actionPressed(.generic, indexPath: nil)
        }
        actionSheetController.addAction(genericStop)
        
        //Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    @IBAction func dateChanged(_ picker: UIDatePicker){
        switch picker.tag{
        case 21:
            TripModel.shared.startDate = picker.date
        case 23:
            TripModel.shared.startTime = picker.date
        case 31:
            TripModel.shared.endDate = picker.date
        case 33:
            TripModel.shared.endTime = picker.date
        default:
            break
        }
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let name = textField.text {
        TripModel.shared.tripName = name
        }
    }
    
    func validate(){
        if TripModel.shared.startDate == nil{
            TripModel.shared.startDate = Date()
        }
        if TripModel.shared.startTime == nil{
            TripModel.shared.startTime = Date()
        }
        if TripModel.shared.endDate == nil{
            TripModel.shared.endDate = Date()
        }
        if TripModel.shared.endDate == nil{
            TripModel.shared.endDate = Date()
        }
        if TripModel.shared.getLocationCount()>0{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
            performSegue(withIdentifier: "suggestedTL", sender: nil)
        }else{
            print("No Location Stops Added")
        }
        
    }
    
}

enum StopActions {
    case location, meal, generic, cancel, delete
}
