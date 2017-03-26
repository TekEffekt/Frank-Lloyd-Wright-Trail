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
    
    var scrollView: UIScrollView!
    var timeline: TimelineView!
    var trip: Trip!
    
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
        google.getOptimizedWayPoints(tripID, completion: {(timeLineCards: [TimelineCardModel]) -> Void in
            guard let trip = RealmQuery.queryTripByID(tripID) else {
                print("Could Not Find Trip by ID")
                return
            }
            
            let tripTime = trip.fullEndDate?.timeIntervalSince(trip.fullStartDate!)
            var driveTime = 0.0
            //add up duration in minutes to see if enough time to complete trip
            for driveCard in timeLineCards {
                if let duration = driveCard.duration {
                    //convert string to seconds (timeIntervalSlice is in seconds)
                    let durationTime = (Double(duration.replacingOccurrences(of: " mins", with: ""))! * 60)
                    driveTime += durationTime
                }
            }
            var timeFrames = [TimeFrame]()
            if (tripTime?.isLess(than: driveTime))! {
                timeFrames.append(TimeFrame(text: "It's not possible to visit the sites with the times you entered", date: "Not enough time given", image: nil))
            } else {
                for (index, card) in timeLineCards.enumerated() {
                    if index == 0 {
                        //home card
                        let timeFrame = TimeFrame(text: "", date: "", image: card.icon!)
                        timeFrames.append(timeFrame)
                    } else if let name = card.name {
                        //location card
                        let timeFrame = TimeFrame(text: name, date: "", image: card.locationImage!)
                        timeFrames.append(timeFrame)
                    } else {
                        //drive card
                        let timeFrame = TimeFrame(text: card.distance!, date: card.duration!, image: card.icon!)
                        timeFrames.append(timeFrame)
                    }
                }
            }
            //back to main thread before UI changes
            DispatchQueue.main.async {
                self.timeline = TimelineView(bulletType: .circle, timeFrames: timeFrames)
                
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

