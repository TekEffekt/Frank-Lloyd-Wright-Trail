//
//  FinalTimeLineVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by MichaelHorning on 3/1/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import UIKit
import RealmSwift

class FinalTimeLineVC: UIViewController {
    
    var scrollView: UIScrollView!
    var timeline:   TimelineView!
    var trip: Trip!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        let button = UIBarButtonItem(title: "Save Trip", style: UIBarButtonItemStyle.plain, target: self, action: #selector(saveSelected))
        self.navigationItem.rightBarButtonItem = button
        
        view.addConstraints([
            NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
            ])
        loadTimeline()
    }
    
    func saveSelected(){
        RealmWrite.save(complete: true, forTrip: self.trip)
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    func loadTimeline(){
        let google = GoogleDirectionsAPI()
        //must send ID to seperate thread can't pass realm objects between threads
        let tripID = trip.id
        
        google.getFinalTimeLine(tripID, completion: {(timeLineCards: [TimelineCardModel]) -> Void in
            guard let trip = RealmQuery.queryTripByID(tripID) else {
                print("Could Not Find Trip by ID")
                return
            }
            
            // sort sitestops by tourtimes
            let sortedList = trip.siteStops.sorted(byKeyPath: "startDate", ascending: true)
            var tourTimes = [Int]()
            for tour in sortedList {
                let duration = DateHelp.getDurationOfTour(startTime: tour.startDate!, endTime: tour.endDate!)
                tourTimes.append(Int(duration))
            }
            
            var timeFrames = [TimeFrame]()
        
            var firstDuration = timeLineCards[1].durationValue
            
            var timeOfDay = DateHelp.getStartOfDayFrom(startDate: sortedList[0].startDate!, firstDriveSeconds: firstDuration!)
            var timeOfDayFormatted = DateHelp.getHoursAndMinutes(from: timeOfDay)
            var durationIndex = 0
            var siteIndex = 0
            
            
            for (index, card) in timeLineCards.enumerated() {
                
                //homecards
                if card.name == "start" {
                    //if new day must restart time
                    if DateHelp.isInSameDay(card.date!, timeOfDay) {
                        let monthAndDay = DateHelp.getShortDateName(date: timeOfDay)
                        timeOfDayFormatted = DateHelp.getHoursAndMinutes(from: timeOfDay)
                        let timeFrame = TimeFrame(text: monthAndDay + timeOfDayFormatted, date: "Leave Home", image: card.icon!, gray: false)
                        timeFrames.append(timeFrame)
                    } else {
                        firstDuration = timeLineCards[index + 1].durationValue
                        timeOfDay = DateHelp.getStartOfDayFrom(startDate: card.date!, firstDriveSeconds: firstDuration!)
                        let monthAndDay = DateHelp.getShortDateName(date: timeOfDay)
                        timeOfDayFormatted = DateHelp.getHoursAndMinutes(from: timeOfDay)
                        let timeFrame = TimeFrame(text: monthAndDay + timeOfDayFormatted, date: "Leave Home", image: card.icon!, gray: false)
                        timeFrames.append(timeFrame)
                    }
                    
                } else if card.name == "end" {
                    timeOfDayFormatted = DateHelp.getHoursAndMinutes(from: timeOfDay)
                    let timeFrame = TimeFrame(text: timeOfDayFormatted, date: "Arrive Home", image: card.icon!, gray: false)
                    timeFrames.append(timeFrame)
                } else if let name = card.name {
                    var cardImage = card.locationImage!
                    //won't be able to reach in time
                    if timeOfDay.isGreaterThanDate(sortedList[siteIndex].startDate!) {
                        let ciImage = CIImage(image: cardImage)
                        let cgImage = self.convertCIImageToCGImage(inputImage: ciImage!)
                        let grayImage = self.convertToGrayScale(image: cgImage!)
                        cardImage = UIImage(cgImage: grayImage)
                        
                        let alertController = UIAlertController(title: "Conflicting Times", message: "You might be late for your tour at \(card.name!).", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(okButton)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    //location card
                    timeOfDay = sortedList[siteIndex].startDate!
                    timeOfDayFormatted = DateHelp.getHoursAndMinutes(from: timeOfDay)
                    let secondTimeOfDay = sortedList[siteIndex].endDate!
                    let secondTimeOfDayFormatted = DateHelp.getHoursAndMinutes(from: secondTimeOfDay)
                    let timeFrame = TimeFrame(text: ("Tour: \(timeOfDayFormatted) - \(secondTimeOfDayFormatted)"), date: name, image: cardImage, gray: false)
                    timeFrames.append(timeFrame)
                    //add time spent at site
                    let tourTime = tourTimes[durationIndex]
                    timeOfDay = DateHelp.addMinutesToDate(minutes: tourTime, date: timeOfDay)
                    timeOfDayFormatted = DateHelp.getHoursAndMinutes(from: timeOfDay)
                    durationIndex += 1
                    siteIndex += 1
                } else {
                    //drive card
                    //get actual int from duration of drive instead of string
                    let seconds = card.durationValue
                    timeOfDay = DateHelp.addSecondsToDate(seconds!, date: timeOfDay)
                    timeOfDayFormatted = DateHelp.getHoursAndMinutes(from: timeOfDay)
                    let duration = card.durationText!.substring(to: card.durationText!.index(before: card.durationText!.endIndex))
                    let timeFrame = TimeFrame(text:"(est arrival: \(timeOfDayFormatted))", date: "\(duration)ute drive", image: card.icon!, gray: false)
                    timeFrames.append(timeFrame)
                }
            }
            
            //back to main thread before UI changes
            DispatchQueue.main.async {
                
                
                
                self.timeline = TimelineView(bulletType: .circle, timeFrames: timeFrames)
                
                self.timeline.isUserInteractionEnabled = false
                
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Timeline"
        //let button = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(doneSelected))
        
        //self.navigationItem.rightBarButtonItem = button
    }
    
    
    private func convertToGrayScale(image: CGImage) -> CGImage {
        let height = image.height
        let width = image.width
        let colorSpace = CGColorSpaceCreateDeviceGray();
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let context = CGContext.init(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context.draw(image, in: rect)
        return context.makeImage()!
    }
    
    private func convertCIImageToCGImage(inputImage: CIImage) -> CGImage! {
        let context = CIContext(options: nil)
        if context != nil {
            return context.createCGImage(inputImage, from: inputImage.extent)
        }
        return nil
    }
    
    
    
    
    
}
