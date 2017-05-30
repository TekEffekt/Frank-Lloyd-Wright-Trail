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
    var sortedByIndex: [Int]!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        activityIndicator.startAnimating()
        
        
        
        view.addConstraints([
            NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
            ])
        
        loadTimeline()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Suggested Order"
        let button = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneSelected))
        self.navigationItem.rightBarButtonItem = button
    }
    
    
    func loadTimeline(){
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        let google = GoogleDirectionsAPI()
        //must send ID to seperate thread can't pass realm objects between threads
        let tripID = trip.id
        google.getOptimizedWayPoints(tripID, completion: {(timeLineCards: [TimelineCardModel], wayPointOrder: [Int], sortedByIndex: [Int]) -> Void in
            
            //back to main thread before UI changes
            DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            var timeFrames = [TimeFrame]()
            
            for (index, card) in timeLineCards.enumerated() {
                if index == 0 {
                    //home card
                    let timeFrame = TimeFrame(text: "Leave Home", date: "", image: card.icon!, gray: false)
                    timeFrames.append(timeFrame)
                } else if let name = card.name {
                    //location card
                    let timeFrame = TimeFrame(text: name, date: "", image: card.locationImage!, gray: false)
                    timeFrames.append(timeFrame)
                } else {
                    //drive card
                    let duration = card.durationText!.substring(to: card.durationText!.index(before: card.durationText!.endIndex))
                    let timeFrame = TimeFrame(text: "\(duration)ute drive", date: "", image: card.icon!, gray: false)
                    timeFrames.append(timeFrame)
                }
            }
                self.wayPointOrder = wayPointOrder
                self.sortedByIndex = sortedByIndex
                
                var string = ""
                for num in wayPointOrder {
                    string += String(num)
                }
                RealmWrite.add(wayPointOrder: string, trip: self.trip)
                self.timeline = TimelineView(bulletType: .circle, timeFrames: timeFrames)
                self.timeline.isUserInteractionEnabled = false
                if self.timeline.timeFrames.count == 1 {
                    self.enoughTime = false
                }
                self.timeline.detailLabelColor = UIColor(hexString: "#A6192E")
                self.timeline.titleLabelColor = UIColor(hexString: "#A6192E")
                let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsetsMake(self.tabBarController!.tabBar.frame.height, 0, 0, 0)
                self.scrollView.contentInset = adjustForTabbarInsets
                self.scrollView.scrollIndicatorInsets = adjustForTabbarInsets
        
                self.scrollView.addSubview(self.timeline)
                
                self.scrollView.addConstraints([
                    NSLayoutConstraint(item: self.timeline, attribute: .left, relatedBy: .equal, toItem: self.scrollView, attribute: .left, multiplier: 1.0, constant: 0),
                    NSLayoutConstraint(item: self.timeline, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: self.scrollView, attribute: .bottom, multiplier: 1.0, constant: -40),
                    NSLayoutConstraint(item: self.timeline, attribute: .top, relatedBy: .equal, toItem: self.scrollView, attribute: .top, multiplier: 1.0, constant: -40),
                    NSLayoutConstraint(item: self.timeline, attribute: .right, relatedBy: .equal, toItem: self.scrollView, attribute: .right, multiplier: 1.0, constant: 0),
                    
                    NSLayoutConstraint(item: self.timeline, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 1.0, constant: 0)
                    ])
                
                self.view.sendSubview(toBack: self.scrollView)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let signupVC = segue.destination as! SignUpVC
        signupVC.wayPointOrder = self.wayPointOrder
        signupVC.sortedByIndex = self.sortedByIndex
        signupVC.trip = self.trip
    }
    
    func doneSelected(_ sender: UIBarButtonItem){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        performSegue(withIdentifier: "signup", sender: nil)
    }
}

