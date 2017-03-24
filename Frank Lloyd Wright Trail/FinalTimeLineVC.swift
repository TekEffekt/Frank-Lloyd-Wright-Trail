//
//  FinalTimeLineVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by MichaelHorning on 3/1/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import UIKit
import RealmSwift

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
private func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


//TripJsonDelegate
class FinalTimeLineVC: UIViewController,TripJsonDelegate {
    
    
    var scrollView: UIScrollView!
    var timeline:   TimelineView!
    var json: JsonParser!
    var sites = List<SiteStop>()
    var allSites = Site.getSites()
    var sites2 = [Site?]()
    var stops = [Stop]()
    var startTime = Date()
    var endTime = Date()
    var tripObj = [TripObject]()
    var newStops = [Stop]()
    var newTripObject = [TripObject]()
    var trip = Trip()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sites = trip.siteStops
        stops = trip.stops
        startTime = trip.startTime!
        endTime = trip.endTime!
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        let button = UIBarButtonItem(title: "Save Trip", style: UIBarButtonItemStyle.plain, target: self, action: #selector(saveSelected))
        self.navigationItem.rightBarButtonItem = button
        
        view.addConstraints([
            NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 29),
            NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
            ])
        
        for i in 0..<sites.count {
            
            sites2.append(sites[i].site)
            
        }
        json = JsonParser(withDelegate: self, locations: sites2)
        json.orderOfLocations(sites2)
    }
    
    func saveSelected(){
        RealmWrite.add(trip: self.trip)
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    func compareSites(_ site1:Stop, site2: [Site]) -> Int {
        
        
        for j in 0..<site2.count{
            if (site1.name == site2[j].title){
                return j
            }
            
        }
        return -1
    }


    // func to get API object data
    func getTripData(_ objects: [TripObject]) {
        var timeFrames: [TimeFrame] = []
        var timeObject = 0.0
        var timeStop = 0.0
        var tripTime = endTime.timeIntervalSince(startTime as Date)
        
        if(objects.count != 0 && newTripObject.count == 0){
        for a in 0..<stops.count {
            if(stops[a] is MealStop || stops[a] is GenericStop) {
                
<<<<<<< HEAD
                timeStop += (stops[a].endTime?.timeIntervalSinceDate(stops[a].startTime!))!
=======
                timeStop = +(stops[a].endTime?.timeIntervalSince(stops[a].startTime! as Date))!
>>>>>>> ui-overhaul
            }
            
        }
        for b in 0..<objects.count {
            timeObject += objects[b].timeValue!
        }
        
        
        
        var newStopTime = 0.0
        for c in 0..<stops.count{
            
                
                if(newStopTime < tripTime){
                    if(stops[c] is SiteStop){
                        if(newStopTime < timeObject){
                        self.newStops.append(stops[c])
                        newStopTime += (timeObject/Double(objects.count))
                        }
                    }
        
                        if(stops[c] is MealStop || stops[c] is GenericStop) {
                            self.newStops.append(stops[c])
<<<<<<< HEAD
                            newStopTime += (newStops[c].startTime?.timeIntervalSinceDate(newStops[c].endTime!))!
=======
                            newStopTime = +(newStops[c].startTime?.timeIntervalSince(newStops[c].endTime! as Date))!
>>>>>>> ui-overhaul
                        }
                }
        }
        
        for d in 0..<newStops.count {
            for e in 0..<sites.count{
                for f in 0..<objects.count{
                if(newStops[d] is SiteStop){
                    if(newStops[d].name == sites[e].name) {
                        var num2 = Double(round(100*(sites[e].site?.lat.value!)!)/100)
                        var num1 = Double(round(100*objects[f].endPoint!)/100)
                        if(num1 == num2){
                        self.newTripObject.append(objects[f])
                        }
                    
                    }
                    
                }
                }
            }
            
        }
        
        for x in 0..<newTripObject.count{
            for y in 0..<newStops.count{
                
                let newStopsY = newStops[y]
                // compare the objects to all the sites and if there is a match create card and add a picture from the list of all sites
                if(Double(round(100*newTripObject[x].endPoint!)/100) == Double(round(100*allSites[compareSites(newStopsY, site2: allSites)].lat.value!)/100)) {
                   
                    timeFrames.append(TimeFrame(text:"Travel distance is " + newTripObject[x].distanceText! + " Travel time is " + newTripObject[x].timeText!, date: allSites[compareSites(newStops[y], site2: allSites)].title!, image: UIImage(named:allSites[compareSites(newStops[y], site2: allSites)].imageName!)))
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
        self.navigationItem.title = "Trip"
        //let button = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(doneSelected))
        
        //self.navigationItem.rightBarButtonItem = button
    }
    
    //    func doneSelected(sender: UIBarButtonItem){
    //        performSegueWithIdentifier("segueToFinal", sender: nil)
    //    }
    
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    
    
}
