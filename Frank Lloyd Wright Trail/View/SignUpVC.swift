//
//  SignUpVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 2/22/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

class SignUpVC: UITableViewController, CLLocationManagerDelegate {
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
    
    
    func openSettings() {
        let path = UIApplicationOpenSettingsURLString
        if let settingsURL = URL(string: path), UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.openURL(settingsURL)
        }
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
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = wayPointOrder[indexPath.section]
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "URLCell", for: indexPath) as! LinkCell
            
            cell.textIndicator.text = "Website To Schedule Tour"
            cell.textIndicator.font = UIFont.systemFont(ofSize: 17)
            cell.icon.image = #imageLiteral(resourceName: "internet")
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneCell", for: indexPath) as! LinkCell
            
            cell.textIndicator.text = "Call To Schedule Tour"
            cell.textIndicator.font = UIFont.systemFont(ofSize: 17)
            cell.icon.image = #imageLiteral(resourceName: "phone")
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "label", for: indexPath) as! LabelCell
            
            cell.signUpLabel.text! = "Tour Start"
            cell.signUpLabel.textColor = UIColor.lightGray
            cell.icon.image = #imageLiteral(resourceName: "calendar")
            if let startDate = trip.siteStops[index].startDate {
                cell.dateLabel.text = DateHelp.getShortDateName(date: startDate) + " \(DateHelp.getHoursAndMinutes(from: startDate))"
            }
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "idDatePick", for: indexPath) as! IdentifiableDatePickCell
            cell.identifiableDatePicker.datePickerMode = .dateAndTime
            cell.identifiableDatePicker.dateType = .StartDate
            cell.identifiableDatePicker.tag = index
            
            if let startDate = sites[index].endDate {
                cell.identifiableDatePicker.date = startDate as Date
            }
        
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "label", for: indexPath) as! LabelCell
            cell.signUpLabel.text! = "Tour End"
            cell.signUpLabel.textColor = UIColor.lightGray
            cell.icon.image = #imageLiteral(resourceName: "calendar")
            if let endDate = trip.siteStops[index].endDate {
                cell.dateLabel.text = DateHelp.getShortDateName(date: endDate) + " \(DateHelp.getHoursAndMinutes(from: endDate))"
            }
            
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "idDatePick", for: indexPath) as! IdentifiableDatePickCell
            cell.identifiableDatePicker.datePickerMode = .dateAndTime
            cell.identifiableDatePicker.dateType = .EndDate
            cell.identifiableDatePicker.tag = index
    
            if let endDate = sites[index].endDate {
                cell.identifiableDatePicker.date = endDate as Date
            }
            
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        
        if URL.absoluteString == "WyomingValleySchool@gmail.com" {
            let mailURL = NSURL(string: "mailto:WyomingValleySchool@gmail.com")! as URL
            UIApplication.shared.openURL(mailURL)
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL, options: [:], completionHandler: nil)
        } else {
             UIApplication.shared.openURL(URL)
        }
        return true
    }
    
    func callLocation(_ sender: UITapGestureRecognizer) {
        let phone = sender.view!
        let phoneNumber = trip.siteStops[phone.tag].site?.phoneNumber!
        
        guard let number = URL(string: "telprompt://" + phoneNumber!) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(number, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
            if let url = URL(string: "telprompt://+\(number)") {
                UIApplication.shared.openURL(url)
            }
        }
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
        
        let index = wayPointOrder[indexPath.section]
        switch indexPath.row {
        case 0:
            let url = trip.siteStops[index].site?.website
            let linkURL = URL(string: url!)
            if url == "WyomingValleySchool@gmail.com" {
                let mailURL = NSURL(string: "mailto:WyomingValleySchool@gmail.com")! as URL
                UIApplication.shared.openURL(mailURL)
            }else if #available(iOS 10.0, *) {
                UIApplication.shared.open(linkURL!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(linkURL!)
            }
        case 1:
            let phoneNumber = trip.siteStops[index].site?.phoneNumber!
            
            guard let number = URL(string: "telprompt://" + phoneNumber!) else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(number, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                if let url = URL(string: "telprompt://+\(number)") {
                    UIApplication.shared.openURL(url)
                }
            }
        default:
            break
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 3 || indexPath.row == 5 {
            if indexPath.row == currentRow && indexPath.section == currentSection && cellTapped {
                return 95
            }
                
            else if indexPath.row == 3 || indexPath.row == 5 {
                return 0
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    
    
    @IBAction func dateChanged(_ picker: IdentifiableDatePicker) {
        switch picker.dateType {
        case .StartDate:
            let index = picker.tag
            RealmWrite.writeSiteStopFullStartDate(index: index, date: picker.date, trip: self.trip)
            let indexPath = IndexPath(row: 2, section: picker.tag)
            tableView.reloadRows(at: [indexPath], with: .none)
            tableView.reloadData()
            tableView.reloadSections(<#T##sections: IndexSet##IndexSet#>, with: <#T##UITableViewRowAnimation#>)
        case .EndDate:
            let index = picker.tag
            RealmWrite.writeSiteStopFullEndDate(index: index, date: picker.date, trip: self.trip)
            let indexPath = IndexPath(row: 4, section: picker.tag)
            tableView.reloadRows(at: [indexPath], with: .none)
            tableView.reloadData()
        }
        
        
    }
    
    
    //toggle function
    private func togglePicker(){
        //pickerVisible = !pickerVisible
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func confirmSelected(_ sender: UIBarButtonItem){
        //validate all stops date entries
        if let error = Validate.siteStops(forTrip: trip) {
            let charset = CharacterSet(charactersIn: "is after")
            let secondcharset = CharacterSet(charactersIn: "same day")
            if error.rangeOfCharacter(from: charset) == nil {
                let alertController = UIAlertController(title: "Invalid Date Entry", message: error, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okButton)
                self.present(alertController, animated: true, completion: nil)
            } else if error.rangeOfCharacter(from: secondcharset) == nil {
                let alertController = UIAlertController(title: "Invalid Date Entry", message: error, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okButton)
                self.present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Incomplete Form", message: error, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okButton)
                self.present(alertController, animated: true, completion: nil)
            }
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
                let alertController = UIAlertController(title: "User Location Access Denied", message: "To allow get a suggested timeline you must enable location services, you may configure it in Settings.", preferredStyle: .alert)
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
        
        //validate network connectivity
        if !Network.reachability.isReachable {
            NetworkAlert.show()
            return
        }
        
        performSegue(withIdentifier: "segueToFinal", sender: nil)
    }
    
    
}
