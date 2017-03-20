//
//  TimelineVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 11/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}




class TimelineVC: UIViewController, TripJsonDelegate {
    
    
    var scrollView: UIScrollView!
    var timeline:   TimelineView!
    var json: JsonParser!
    var sites = TripModel.shared.getLocations()
    var allSites = Site.getSites()
    var sites2 = [Site?]()
    var sharedTripObject: [TripObject] = []
    var stops = TripModel.shared.stops
    var startTime = TripModel.shared.startTime
    var endTime = TripModel.shared.endTime
    var newStops = [Stop]()
    var newTripObject = [TripObject]()
    var trip = Trip()
    
    let date = Date()
    let calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        view.addConstraints([
            NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 29),
            NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
            ])
        for i in 0..<sites!.count {
        
            sites2.append(sites![i].site)
        }
        json = JsonParser(withDelegate: self, locations: sites2)
        getTripData(json.orderOfLocations(sites2))
    }
    
    func compareSites(_ site1:Site?, site2: [Site]) -> Int {

  
            for j in 0..<site2.count{
            if ( Double(round(100*(site1?.lat)!)/100) == Double(round(100*site2[j].lat)/100)){
                 return j
            }
        
            }
        return -1
    }
    

    // func to get API object data
    func getTripData(_ objects: [TripObject]) {
        var timeFrames: [TimeFrame] = []
        
        var objectTime = 0.0
        var tripTime = endTime?.timeIntervalSince(startTime! as Date)

        if(objects.count != 0 && newTripObject.count == 0){
        for b in 0..<objects.count {
            objectTime = +objects[b].timeValue!
            if(objectTime < tripTime){
                newTripObject.append(objects[b])
                
                
            }
        }
        
        // attach the correct image to the sites
        var count = 0
        
        if(newTripObject.count < 0) {
            timeFrames.append(TimeFrame(text: "Home", date: "9:00am", image: nil))}
        if (newTripObject.count == 0){
            timeFrames.append(TimeFrame(text: "It's not possible to visit the sites with the times you entered", date: "Not enough time given", image: nil))
        } else{
        for i in 0..<newTripObject.count{
            for j in 0..<sites2.count{
              
               // compare the objects to all the sites and if there is a match create card and add a picture from the list of all sites
                 if (Double(round(100*newTripObject[i].endPoint!)/100) == Double(round(100*allSites[compareSites(sites2[j], site2: allSites)].lat)/100)){
                     //timeFrames.append(TimeFrame(text: "Drive time" , date: "9:00am", image: nil))
                    timeFrames.append(TimeFrame(text:"Travel distance is " + newTripObject[i].distanceText! + "iles" + ". Travel time is " + newTripObject[i].timeText! + ".", date: allSites[compareSites(sites2[j], site2: allSites)].title, image: UIImage(named:allSites[compareSites(sites2[j], site2: allSites)].imageName!)))
                
                }
            }
        
        }
    }
        }
        
        timeline = TimelineView(bulletType: .circle, timeFrames: timeFrames)
        
        
        scrollView.addSubview(timeline)
        scrollView.addConstraints([
            NSLayoutConstraint(item: timeline, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .right, relatedBy: .equal, toItem: scrollView, attribute: .right, multiplier: 1.0, constant: 0),
            
            NSLayoutConstraint(item: timeline, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1.0, constant: 0)
            ])
        
        view.sendSubview(toBack: scrollView)
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Suggested Trip"
        let button = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneSelected))
        self.navigationItem.rightBarButtonItem = button
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let signupVC = segue.destination as! SignUpVC
        signupVC.trip = self.trip
    }
    
    func doneSelected(_ sender: UIBarButtonItem){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        performSegue(withIdentifier: "signup", sender: nil)
    }
    

    override var prefersStatusBarHidden : Bool {
        return true
    }
    


}

