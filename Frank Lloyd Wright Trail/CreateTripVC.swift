//
//  CreateTripVC.swift
//  Frank Lloyd Wright Trail
//  This view controller is used to control the view which asks the user to add any stops if necessary and to also to select their start dates and end dates, taking in mind which trip type they selected
//  Created by Max on 2/14/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import RealmSwift
import CoreLocation

class CreateTripVC : FormViewController, CLLocationManagerDelegate {
    
    let section = ["TRIP", "STOPS"]
    var labels = [["TRIP"], ["Add Stop"]]
    var tappedStopType: StopActions?
    var cellTapped = false
    var currentRow = -1
    var currentSection = -1
    var trip: Trip!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Create Trip"
        let button = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(nextSelected))
        
        self.navigationItem.rightBarButtonItem = button
        tableView.reloadData()
    }
    
    func nextSelected(_ sender: UIBarButtonItem) {
        validateAndSave()
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
        if section == 0 {
            return 1
        } else {
            return trip.siteStops.count + 1
        }
        
    }
    
    
    //set header titles
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Trip Name"
        }
        return self.section[section]
    }
    
    //configure cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //name cell
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell") as! NameCell
            cell.tripNameField.font = UIFont.systemFont(ofSize: 17)
            cell.tripNameField.text! = trip.tripName
            cell.tripNameField.placeholder = "Trip Name"
            return cell
        }
            //add stop cell
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AddStopCell
            //add stop cell
            if indexPath.row == trip.siteStops.count{
                cell.stopName.text! = "Add Stop"
                cell.modifyImage.image = UIImage(named: "Add")
                cell.stopName.textColor = UIColor(hexString: "#0073FF")
                return cell
            }
                //stop added cell
            else{
                if trip.siteStops.count > 0{
                    if let name = trip.siteStops[indexPath.row].name{
                        cell.stopName.text! = name
                    }
                    cell.stopName.adjustsFontSizeToFitWidth = true
                    cell.modifyImage.image = UIImage(named: "Minus")
                    cell.stopName.textColor = UIColor.black
                    return cell
                }
            }
        }
        
        return UITableViewCell()
    }
    
    
    //cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1{
            if(indexPath.row == trip.siteStops.count){
                 performSegue(withIdentifier: "AddLocation", sender: nil)
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
                return 110
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
            cell.datePicker.datePickerMode = UIDatePickerMode.time
        }
    }
    
    
    //action sheet button clicked
    private func actionPressed(_ stopAction:StopActions, indexPath : IndexPath?) {
        switch stopAction {
        case .cancel:
            dismiss(animated: true, completion: nil)
        case .delete:
            let indexPath = indexPath
            if let cell = tableView.cellForRow(at: indexPath!) as? AddStopCell{
                let stopName = cell.stopName.text!
                
                for (index, stop) in trip.siteStops.enumerated(){
                    if stop.name! == stopName {
                        RealmDelete.siteStop(index: index, trip: self.trip)
                        tableView.deleteRows(at: [indexPath!], with: .automatic)
                        break
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let locationVC = segue.destination as? ChooseDestinationVC{
            locationVC.trip = self.trip
        }else if let suggestedTLVC = segue.destination as? TimelineVC{
            suggestedTLVC.trip = self.trip
        }
    }
    
    
    //create alert popup
    private func alertPopUp(_ indexPath: IndexPath){
        
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
    private func actionSheet(){
        let actionSheetController: UIAlertController = UIAlertController(title: "Choose a Type of Stop", message: "", preferredStyle: .actionSheet)
        
        //Create and add the "Cancel" action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
            self.actionPressed(.cancel, indexPath: nil)
        }
        actionSheetController.addAction(cancelAction)
        
        //Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let name = textField.text {
          RealmWrite.writeTripName(tripName: name, trip: self.trip)
        }
    }
    
    func validateAndSave(){
        //validate stop count
        if trip.siteStops.count == 0 {
            let alertController = UIAlertController(title: "No Locations", message: "You must add at least one location to create a trip.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okButton)
            self.present(alertController, animated: true, completion: nil)
        }

        //validate user location
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() {
            
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                let alertController = UIAlertController(title: "User Location Access Denied", message: "To get a suggested timeline you must enable location services, you may configure it in Settings.", preferredStyle: .alert)
                let settingsButton = UIAlertAction(title: "Settings", style: .default) {
                    action -> Void in
                    self.openSettings()
                }
                alertController.addAction(settingsButton)
                let okButton = UIAlertAction(title: "OK", style: .default) {
                    action -> Void in
                    return
                }
                alertController.addAction(okButton)
                self.present(alertController, animated: true, completion: nil)
            default:
                break
            }
        }
        
        //validate network connection
        if !Network.reachability.isReachable {
            NetworkAlert.show()
            return
        }
        
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        RealmWrite.writeTripName(tripName: trip.tripName, trip: self.trip)
        performSegue(withIdentifier: "suggestedTL", sender: nil)
        
    }
    
    func openSettings() {
        let path = UIApplicationOpenSettingsURLString
        if let settingsURL = URL(string: path), UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.openURL(settingsURL)
        }
    }
}




enum StopActions {
    case cancel, delete
}
