//
//  TimelineVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 11/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit
import RealmSwift

class TimelineVC: UIViewController {
    var enoughTime = true
    var scrollView: UIScrollView!
    var timeline: TimelineView!
    var trip: Trip!
    var wayPointOrder = [Int]()
    
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
        
        loadTimeline()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Suggested Trip"
        let button = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneSelected))
        self.navigationItem.rightBarButtonItem = button
    }
    
    
    func loadTimeline(){
        let google = GoogleDirectionsAPI()
        //must send ID to seperate thread can't pass realm objects between threads
        let tripID = trip.id
        google.getOptimizedWayPoints(tripID, completion: {(timeLineCards: [TimelineCardModel], wayPointOrder: [Int]) -> Void in
            guard let trip = RealmQuery.queryTripByID(tripID) else {
                print("Could Not Find Trip by ID")
                return
            }
            
            let tripTime = trip.endTime?.timeIntervalSince(trip.startTime!)
            var driveTime = 0.0
            //add up duration in minutes to see if enough time to complete trip
            for driveCard in timeLineCards {
                if let duration = driveCard.duration {
                    //convert string to seconds (timeIntervalSlice is in seconds)
                    let durationTime = (Double(duration.replacingOccurrences(of: " mins", with: ""))! * 60)
                    driveTime += durationTime
                }
            }
            //consider hour spent at each site stop
            driveTime += (Double(trip.siteStops.count) * 3600.0)
            
            var timeFrames = [TimeFrame]()
       
            if (tripTime?.isLess(than: driveTime))! {
                timeFrames.append(TimeFrame(text: "", date: "Not Enough Time For Trip", image: UIImage(named:"NoEntry")!))
            } else {
                var timeOfDay = trip.startTime
                var timeOfDayFormatted = DateHelp.getHoursAndMinutes(from: timeOfDay!)
                for (index, card) in timeLineCards.enumerated() {
                    if index == 0 || index == timeLineCards.count - 1 {
                        //home card
                        let timeFrame = TimeFrame(text: "", date: timeOfDayFormatted, image: card.icon!)
                        timeFrames.append(timeFrame)
                    } else if let name = card.name {
                        //location card
                        let timeFrame = TimeFrame(text: name, date: ("Tour Start: \(timeOfDayFormatted)"), image: card.locationImage!)
                        timeFrames.append(timeFrame)
                        //assume hour spent at site
                        timeOfDay = DateHelp.addHoursToDate(hours: 1, date: timeOfDay!)
                        timeOfDayFormatted = DateHelp.getHoursAndMinutes(from: timeOfDay!)
                    } else {
                        //drive card
                        //get actual int from duration of drive instead of string
                        let minutesString = card.duration!
                        let minutesNum = minutesString.components(separatedBy: " ").flatMap { Int($0.trimmingCharacters(in: .whitespaces))}[0]
                        timeOfDay = DateHelp.addMinutesToDate(minutes: minutesNum, date: timeOfDay!)
                        timeOfDayFormatted = DateHelp.getHoursAndMinutes(from: timeOfDay!)
                        let timeFrame = TimeFrame(text: "\(card.duration!) (est arrival: \(timeOfDayFormatted))", date: "", image: card.icon!)
                        timeFrames.append(timeFrame)
                    }
                }
            }
            //back to main thread before UI changes
            DispatchQueue.main.async {
                self.wayPointOrder = wayPointOrder
                self.timeline = TimelineView(bulletType: .circle, timeFrames: timeFrames)
                if self.timeline.timeFrames.count == 1 {
                    self.enoughTime = false
                }
                self.timeline.detailLabelColor = UIColor(hexString: "#A6192E")
                self.timeline.titleLabelColor = UIColor(hexString: "#A6192E")
                self.scrollView.addSubview(self.timeline)
                self.scrollView.addConstraints([
                    NSLayoutConstraint(item: self.timeline, attribute: .left, relatedBy: .equal, toItem: self.scrollView, attribute: .left, multiplier: 1.0, constant: 0),
                    NSLayoutConstraint(item: self.timeline, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: self.scrollView, attribute: .bottom, multiplier: 1.0, constant: 0),
                    NSLayoutConstraint(item: self.timeline, attribute: .top, relatedBy: .equal, toItem: self.scrollView, attribute: .top, multiplier: 1.0, constant: 0),
                    NSLayoutConstraint(item: self.timeline, attribute: .right, relatedBy: .equal, toItem: self.scrollView, attribute: .right, multiplier: 1.0, constant: 0),
                    
                    NSLayoutConstraint(item: self.timeline, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 1.0, constant: 0)
                    ])
                
                self.view.sendSubview(toBack: self.scrollView)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let signupVC = segue.destination as! SignUpVC
        signupVC.wayPointOrder = self.wayPointOrder
        signupVC.trip = self.trip
    }
    
    func doneSelected(_ sender: UIBarButtonItem){
        if enoughTime {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        performSegue(withIdentifier: "signup", sender: nil)
        } else {
            print("Not Enough Time for Trip")
        }
    }
    
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    

}

